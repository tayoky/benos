[bits 64]

section .multiboot2
    align 8
multiboot_header:
    dd 0xe85250d6
    dd 0
    dd header_end - multiboot_header
    dd -(0xe85250d6 + 0 + (header_end - multiboot_header))

    dd 0
    dd 8
header_end:

section .text
    global _start
    extern kernel_main
    
_start:
    mov rsp, 0x90000

    call kernel_main

    cli
    hlt