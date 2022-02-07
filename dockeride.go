package main

import (
	"bufio"
	"context"
	"fmt"
	"io"
	"os"

	"github.com/docker/docker/api/types"
	"github.com/docker/docker/api/types/container"
	"github.com/docker/docker/client"
	"github.com/docker/docker/pkg/stdcopy"
)

// its quite difficult to pass user input through to a container programatically.
// https://stackoverflow.com/questions/58732588/accept-user-input-os-stdin-to-container-using-golang-docker-sdk-interactive-co
func main() {
	var inout chan []byte
	inout = make(chan []byte)
	img := "registry.gitlab.com/deepcypher/dockeride:master"

	// Setup client to Docker daemon using docker SDK and environment variables
	ctx := context.Background()
	cli, err := client.NewClientWithOpts(client.FromEnv, client.WithAPIVersionNegotiation())
	if err != nil {
		panic(err)
	}

	// Pull Docker image
	reader, err := cli.ImagePull(ctx, img, types.ImagePullOptions{})
	if err != nil {
		panic(err)
	}
	defer reader.Close()
	io.Copy(os.Stdout, reader)

	// Create a container from the now pulled image
	resp, err := cli.ContainerCreate(ctx, &container.Config{
		Image:        img,
		AttachStderr: true,
		AttachStdin:  true,
		Tty:          true,
		AttachStdout: true,
		OpenStdin:    true,
		// Cmd: []string{"echo", "hello world"},
	}, nil, nil, nil, "")
	if err != nil {
		panic(err)
	}

	// Start the container in question in the background
	if err := cli.ContainerStart(ctx, resp.ID, types.ContainerStartOptions{}); err != nil {
		panic(err)
	}

	// Attatch to container interactiveley
	waiter, err := cli.ContainerAttach(ctx, resp.ID, types.ContainerAttachOptions{
		Stderr: true,
		Stdout: true,
		Stdin:  true,
		Stream: true,
	})

	go io.Copy(os.Stdout, waiter.Reader)
	go io.Copy(os.Stderr, waiter.Reader)
	if err != nil {
		panic(err)
	}

	go func() {
		scanner := bufio.NewScanner(os.Stdin)
		for scanner.Scan() {
			inout <- []byte(scanner.Text())
		}
	}()

	go func(w io.WriteCloser) {
		for {
			data, ok := <-inout
			if !ok {
				fmt.Println("!ok")
				w.Close()
				return
			}
			w.Write(append(data, '\n'))
		}
	}(waiter.Conn)

	// Wait for container
	statusCh, errCh := cli.ContainerWait(ctx, resp.ID, container.WaitConditionNotRunning)
	select {
	case err := <-errCh:
		if err != nil {
			panic(err)
		}
	case <-statusCh:
	}

	// Get logs out from the container as for what it did
	out, err := cli.ContainerLogs(ctx, resp.ID, types.ContainerLogsOptions{ShowStdout: true})
	if err != nil {
		panic(err)
	}
	stdcopy.StdCopy(os.Stdout, os.Stderr, out)
}
