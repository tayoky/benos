[bits 16]
[org 0x0]

jmp start
%include "fs/utils.asm"
%include "kernel/cmdmacro.asm"

%macro check_command 3
    mov di, %1
    call %2
    jc %3
    mov si, prpBuffer
%endmacro

start:
; Initialize segments
    mov ax, 0x1000
    mov ds, ax
    mov es, ax
    mov ax, 0x8000
    mov ss, ax
    xor sp, sp

    cld

    mov si, segInit
    call STDIO_print

; Kernel loaded
    mov si, krnLoaded
    call STDIO_print

    mov si, SYS_NAME
    call STDIO_print
    mov si, prtTitle
    call STDIO_print
    mov si, SYS_VERSION
    call STDIO_print
    mov si, NEWLINE
    call STDIO_print

wait_for_key:
; Wait if a key is pressed to start the shell
    mov si, keyPress
    call STDIO_print

    call STDIO_waitkeypress

    cmp al, 0                   ; Check if al is not 0
    jnz .start_shell

    jmp wait_for_key
.start_shell:
    call VIDEO_clear

    jmp shell_begin

; Shell
shell_begin:
; Display the prompt
    mov si, prompt
    call STDIO_print

; Start the input
    mov di, prpBuffer
    call STDIO_input

    mov si, prpBuffer

; Manage scrollup
    inc byte [lnsOnScreen]
    cmp byte [lnsOnScreen], 24
    je .scrollup

; Check commands
    check_command cmdInfo, STRING_compare_start, command_info

    check_command cmdHelp, STRING_compare_start, command_help

    check_command cmdHalt, STRING_compare, command_halt

    check_command cmdClear, STRING_compare, command_clear

    check_command cmdLs, STRING_compare, command_ls

    check_command cmdTouch, STRING_compare_start, command_touch

    check_command cmdRm, STRING_compare_start, command_rm

    jmp .command_unknow

    .command_unknow:
    ; Handle unknow commands
    ; Check if the command is empty
        call STRING_length
        cmp ax, 0
        jz shell_begin

    ; Check if the command contains something
        mov si, cmdUnknow
        call STDIO_print

        jmp shell_begin

; Continue the prompt
    jmp shell_begin
.scrollup:
; Scroll up the screen
    mov al, 1
    dec byte [lnsOnScreen]
    call VIDEO_scrollup
    
    jmp shell_begin

; ----- INCLUDES -----
%include "benlib/stdio.asm"
%include "benlib/video.asm"
%include "benlib/string.asm"
%include "benlib/disk.asm"
%include "benlib/general.asm"

%include "kernel/help.asm"
%include "kernel/info.asm"
%include "kernel/halt.asm"
%include "kernel/clear.asm"
%include "kernel/fscmd.asm"

; ----- DATA -----
segInit:            db      "[ OK ] Segments initialized", 13, 10, 0
krnLoaded:          db      "[ OK ] Kernel loaded successfully", 13, 10, 0
prompt:             db      "BenOS> ", 0
prtTitle:           db      " version ", 0
keyPress:           db      "Press a key to continue...", 0

prpBuffer:          times 256 db 0

lnsOnScreen:        db      0

cmdUnknow:          db      "Unknow command.", 13, 10, 0
cmdInfo:            db      "info", 0
cmdHelp:            db      "help", 0
cmdHalt:            db      "halt", 0
cmdClear:           db      "clear", 0
cmdLs:              db      "ls", 0
cmdTouch:           db      "touch", 0
cmdRm:              db      "rm", 0