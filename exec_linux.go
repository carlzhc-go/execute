//go:build linux

package main

import "os"
import "syscall"

func execute(argv []string) error {
	err := syscall.Exec(argv[0], argv, os.Environ())
	if err != nil {
		panic(err)
	}
	return err
}
