//go:build linux

package main

import "os"
import "syscall"

func execute(argv []string) error {
	return syscall.Exec(argv[0], argv, os.Environ())
}
