// Generics linting, formatting, and syntax highlighting sample file.
// This package should help indicate how go specific packages and configuration is behaving.
package main

import (
	"log"
)

// some random bs for you to inspect with linter and autocompleter
func main() {
	out, err := genericFunctionAdd(2, 3)
	if err != nil {
		log.Fatal(err)
	}
	log.Printf("Function result: %v", out)
	a := NewSomeInterface(3.0)
	b := NewSomeInterface(4.5)
	c := a.Add(b)
	log.Printf("Method result: %v", c.GetData())

}

//
// FUNCTION USE OF GENERICS
//

// desirables: defining a type interface for subset of acceptable types for generics
type desirables interface {
    ~complex128 | ~float64 | ~int
}

// genericAdd: do something for the sake of sampling lint etc
func genericFunctionAdd[T desirables](a, b T) (T, error) {
	return (a + b), nil
}

//
// INTERFACES AND METHOD USAGE OF GENERICS
//

// SomeInterface wraps generics maths methods
type SomeInterface[T desirables] interface {
	Add(other SomeInterface[T]) SomeInterface[T] // add: *SomeInterface to self returning new *SomeInterface
	Mul(other SomeInterface[T]) SomeInterface[T] // mul: multiply *SomeInterface to self returning new *SomeInterface
	GetData() T
}

// someStruct: underlying struct used to satisfy SomeInterface
type someStruct[T desirables] struct {
	data  *T // some argitrary data we compute with
}

// NewSomeInterface factory for some generic interface given some initial data
// https://stackoverflow.com/questions/44370277/type-is-pointer-to-interface-not-interface-confusion
// interfaces are either values or pointer to some struct. The syntax is identical after assignment.
// one should almost never have an pointer TO an interface that THEN points to a struct
// this function retuns the address to a struct as an interface, NOT an interface-pointer
func NewSomeInterface[T desirables](data T) SomeInterface[T] {
	return &someStruct[T]{data:&data}
}

//
// STRUCT -> INTERFACING METHODS
//

// GetData: from internal underlying struct
func (some *someStruct[T]) GetData() T {
	return *(some.data)
}

// Add: internal data from structs
func (some *someStruct[T]) Add(other SomeInterface[T]) SomeInterface[T] {
	out := *some.data + other.GetData()
	return NewSomeInterface(out)
}

// Mul: Multiply internal data from structs
func (some *someStruct[T]) Mul(other SomeInterface[T]) SomeInterface[T] {
	out := *some.data * other.GetData()
	return NewSomeInterface(out)
}
