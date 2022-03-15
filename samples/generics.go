package main

import "fmt"

func main() {
	fmt.Println("vim-go")
}

func genericAdd[T any]() {
	fmt.Println("meh")
}
