ENTRY(_start)
OUTPUT_FORMAT("binary")
OUTPUT(boot.bin)

SECTIONS {
	. = 0x7c00;
	.boot : {
		*(.boot)
	}
}