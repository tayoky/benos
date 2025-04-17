section .text

[bits 16]
extern kmain
global _start
_start:
	call kmain