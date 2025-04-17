%include "benlib.asm"

extern shell_begin
extern prpBuffer
extern cmdTouch
extern cmdRm

global command_ls
global command_touch
global command_rm

[bits 16]
section .text
command_ls:
    call DISK_list_files

    jmp shell_begin

command_touch:
    mov si, prpBuffer
    mov di, cmdTouch
    call STRING_compare
    jc .error

    mov si, prpBuffer
    call STRING_split

    mov si, di
    call STRING_length
    cmp ax, 12
    jne .error_name

    mov si, di
    call DISK_create_file

    jmp shell_begin

.error_name:
    mov si, .message_name
    call STDIO_print

    jmp shell_begin

.error:
    mov si, .message_error
    call STDIO_print

    jmp shell_begin

section .data
.message_error:         db          "No filename given", 13, 10, 0
.message_name:          db          "Filename must have 12 characters", 13, 10, 0

section .text
command_rm:
    mov si, prpBuffer
    mov di, cmdRm
    call STRING_compare
    jc .error

    mov si, prpBuffer
    call STRING_split

    mov si, di
    call STRING_length
    cmp ax, 12
    jne .error_name

    mov si, di
    call DISK_remove_file

    jmp shell_begin

.error_name:
    mov si, .message_name
    call STDIO_print

    jmp shell_begin

.error:
    mov si, .message_error
    call STDIO_print

    jmp shell_begin

section .data
.message_error:         db          "No filename given", 13, 10, 0
.message_name:          db          "Filename must have 12 characters", 13, 10, 0
