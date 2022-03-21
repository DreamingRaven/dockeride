package main

import (
	"log"
)

// some random bs for you to inspect with linter and autocompleter
func main() {
	out, err := genericAdd(2, 3)
	if err != nil {
		log.Fatal(err)
	}
	log.Printf("output result: %v", out)

}

// desirables: defining a subset of acceptable types of our generic type
type desirables interface {
    ~complex128 | ~float64 | ~int
}

// genericAdd: do something for the sake of sampling lint etc
func genericAdd[T desirables](a, b T) (T, error) {
	return (a + b), nil
}
