package main

import "testing"

func TestHello(t *testing.T) {
    if Hello("Jenkins") != "Hello, Jenkins!" {
        t.Fatal("unexpected greeting")
    }
}
