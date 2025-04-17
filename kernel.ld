ENTRY(kmain)
OUTPUT_FORMAT("binary")
OUTPUT(kernel.bin)

SECTIONS {
	. = 0x8000;
	.start : {
		*(.start)
	}
	.text : {
		*(.text .text.*)
	}
	.data : {
		*(.data .data.*)
	}
}