//go:build linux

package main

import "os"
import "syscall"

func hasStickyBit(f string) bool {
	var err error
	fi, err := os.Stat(f)
	if err != nil {
		return false
	}

	stat, ok := fi.Sys().(*syscall.Stat_t)
	if !ok {
		return false
	}

	return stat.Mode&syscall.S_ISVTX != 0
}

func runAsRoot() {
	if hasStickyBit(os.Args[0]) {
		if err := syscall.Setuid(0); err != nil {
			panic(err)
		}
	}
}
