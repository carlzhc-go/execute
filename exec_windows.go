//go:build windows

package main

import "os"
import "os/exec"

func execute(argv []string) error {
	cmd := exec.Command(argv[0], argv[1:]...)
	cmd.Stdin = os.Stdin
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	cmd.Run()
	if cmd.ProcessState != nil {
		os.Exit(cmd.ProcessState.ExitCode())
	}
	os.Exit(-1)
	return nil
}
