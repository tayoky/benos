ENTRY(_start)
OUTPUT_FORMAT("binary")
OUTPUT(kernel.bin)
STARTUP(start.o)

SECTIONS {
	. = 0x8000;
	.text : {
		*(.text .text.*)
	}
	.data : {
		*(.data .data.*)
	}
}