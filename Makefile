SHELL := /bin/bash
s = execute.go
cmd = date
exe = $(basename $s)
len = 999999
src = $(wildcard *.go)
mark = 55AA
fill = 00

all:
	@echo "usage: make exe                                     # build binary"
	@echo "       make command cmd='COMMAND TO RUN\0ARG1...'   # update binary with the command to run"

exe: $(exe)
$(exe): $(src)
	gofmt -w .
	go build -gcflags "-N -l" .

command cmd: bin := $(notdir $(firstword $(subst \0, ,$(cmd))))
command cmd: $(exe).dump
	echo -n -e "$(cmd)" | xxd -c $(len) -p -u > cmd.dump
	c=`cat cmd.dump`; l=`stat -c %s cmd.dump`; wl=$$(((l-4)/2)); \
		sed -re "s#$(mark)($(fill)){$$wl}#$$c#" $(exe).dump > $(bin).dump
	xxd -r -p -u $(bin).dump $(bin)
	! git diff --no-index --color-words='..' -U0 <(fold $(exe).dump) <(fold $(bin).dump)
	chmod +x $(bin)

$(exe).dump: $(exe)
	xxd -c $(len) -p -u $< $@

clean:
	-git clean -X -f

.PHONY: all exe command cmd clean
