%include "benlib.asm"

global command_halt
global command_reboot

[bits 16]
section .text
command_halt:
; Stop the system
    hlt
    
command_reboot:
    mov ah, 0x19
    int 0x19

    mov si, .msg
    call STDIO_print

    hlt
section .data
.msg:   db  "[ ERR ] Failed to reboot. Stopping..."
