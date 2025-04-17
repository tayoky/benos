ENTRY(_start)
OUTPUT_FORMAT("binary")

STARTUP(boot.o)

OUTPUT(benos.bin)

SECTIONS {
	. = 0x7C00;
	.boot : {
		*(.boot)
	}

	.text : {
		*(.text .text.*)
	}

	.data : {
		*(.data .data.*)
	}
}


