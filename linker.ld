ENTRY(_start)
OUTPUT_FORMAT("binary")


OUTPUT(benos.bin)

SECTIONS {
	. = 0x7C00;
	.boot : {
		*(.boot)
	}
	kernel_base = .;
	.text : {
		*(.text .text.*)
	}

	.data : {
		*(.data .data.*)
	}
}


