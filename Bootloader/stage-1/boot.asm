[org 0x7c00]    ; this is where the boot loader is started
[bits 16]       ; tell the nasm that we are in 16 bits real mode

; IMPORTANT THIS FILE CANNOT BE MORE THAN 512 BYTES IN SIZE
; AS THE FAT SPECIFICATION SAYS JUST 1 SECTOR IS RESERVED 
STACK equ 0x9000


JMP SHORT start  ; jump to the main skiping the bios parameter block which starts at start
nop             ; NOP means the no cpu operation for this instruction

bdb_oem:                    db 'MSWIN4.1'           ; recommended value, but can be any 8 bytes string
bdb_bytes_per_sector:       dw 512                  ; 512 bytes per sector is the standard for floppy disk 
bdb_sectors_per_cluster:    db 2                    ; 1024 bytes per cluster seems good, might change later
bdb_no_of_reversed_sectors: dw 1                    ; 1 sector for bootloader
bdb_no_of_fats:             db 2                    ; we'll have 2 file allocation tables
bdb_dir_entries_count:      dw 0x0E0                ; 0x0E0 = 224 which standard size for 1.44 mb floppy
bdb_total_sectors:          dw 2880                 ; 2880 * 512 = 1.44 mb
bdb_media_descriptor_type:  db 0x0F0                 ; F0 = 3.5" floppy disk
bdb_sectors_per_fat:        dw 9                    ; 9 sectors/fat
bdb_sectors_per_track:      dw 18
bdb_heads:                  dw 2
bdb_hidden_sectors:         dd 0
bdb_large_sector_count:     dd 0

; extended boot record
ebr_drive_number:           db 0                    ; 0x00 floppy, 0x80 hdd, useless
                            db 0                    ; reserved
ebr_signature:              db 0x29
ebr_volume_id:              db 0x24, 0x11, 0x20, 0x03 ; serial number, value doesn't matter
ebr_volume_label:           db 'Madhav OS'          ; 11 bytes, padded with spaces
ebr_system_id:              db 'FAT12   '             ; 8 bytes

start:
    cli              ; no interrupts during setup refer the Readme under /Bootloader 
    cld              ; string ops go forward
    xor ax, ax       ; Set all segments to zero
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, STACK    ; Set stack
    mov sp, bp
    sti              ; enable interrupts after setup

jmp $ 

times 510-($-$$) db 0
dw 0xaa55

