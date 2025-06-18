SHELL := /bin/bash
s = execute.go
cmd = date
exe = $(basename $s)
len = 999999

all:
	@echo "usage: make exe                                     # build binary"
	@echo "       make command cmd='COMMAND TO RUN\0ARG1...'   # update binary with the command to run"

exe: $(exe)
$(exe):
	gofmt -w .
	go build -gcflags "-N -l" .

command: $(exe)
	xxd -c $(len) -p -u $< $<.dump
	echo -n -e "$(cmd)" | xxd -c $(len) -p -u > cmd.dump
	c=`cat cmd.dump`; l=`stat -c %s cmd.dump`; wl=$$(((l-4)/2)); sed -re "s/55AA(00){$$wl}/$$c/" $<.dump > $<.dump.1
	xxd -r -p -u $<.dump.1 $<.1
	diff -U 0 <(fold $<.dump) <(fold $<.dump.1) ||:
	chmod +x $<.1

clean:
	-rm -f $(exe) *.dump* *.1
	-rm -f *.log *~
