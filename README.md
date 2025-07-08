Execute
===========
A simple wrapper to run other commands with arguments.
Mainly used for commands should be run as other users, and use setuid on the wrapper.

Build the wrapper
-----------------
Run `make exe` to build a binary wrapper program.


Customize the wrapper
---------------------
Run `make command cmd='...'` to update the wrapper with the command to run.
