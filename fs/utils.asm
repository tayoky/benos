; ===================================================================
; utils.asm
;
; Released under MIT license (see LICENSE for more infos)
;
; This file contains every informations about the filesystem. These
; informations are used in other parts of the system to interact with
; the filesystem.
; ===================================================================

%include "fs.asm"
%include "benlib.asm"

global fileTable

[bits 16]

section .text

fileTable:                          times FILE_TABLE_ENTRIES * FILE_ENTRY_SIZE db MARK_FREE_ENTRY

; Input:
; (lea) si: [fileTable]
; ax: FILE_TABLE_SECTOR
; bx: DRIVE_NUMBER
FS_save_file_table:
    mov cx, FILE_TABLE_ENTRIES

.saving:
    push ax
    push bx

    lea dx, [si]
    mov ah, 0x03
    int 0x13
    jc DISK_error

    pop bx
    pop ax

    add si, FILE_ENTRY_SIZE
    loop .saving

    ret

; Input:
; (lea) di: [fileTable]
; ax: FILE_TABLE_SECTOR
; bx: DRIVE_NUMBER
FS_load_file_table:
    mov cx, FILE_TABLE_ENTRIES

.loading:
    push ax
    push bx

    lea dx, [di]
    mov ah, 0x02
    int 0x13
    jc DISK_error

    pop bx
    pop ax

    add di, FILE_ENTRY_SIZE
    loop .loading

    ret
