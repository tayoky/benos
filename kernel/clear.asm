%include "benlib.asm"

extern shell_begin

global command_clear

[bits 16]
section .text

command_clear:
    call VIDEO_clear

    jmp shell_begin
