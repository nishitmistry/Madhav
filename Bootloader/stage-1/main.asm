[org 0x7c00]    ; this is where the boot loader is started
[bits 16]       ; forces the use of 16-bit operands, addressing modes, and register sizes
%include "../constants.asm"

; IMPORTANT THIS FILE CANNOT BE MORE THAN 512 BYTES IN SIZE
; AS OUR FAT SPECIFICATION SAYS JUST 1 SECTOR IS RESERVED 
STACK equ 0x9000


JMP SHORT start     ; jump to the main skiping the bios parameter block which starts at start
nop                 ; NOP means the no cpu operation for this instruction

bdb_oem:                    db 'MSWIN4.1'           ; recommended value, but can be any 8 bytes string
bdb_bytes_per_sector:       dw 512                  ; 512 bytes per sector is the standard for floppy disk 
bdb_sectors_per_cluster:    db 2                    ; 1024 bytes per cluster seems good, might change later
bdb_no_of_reversed_sectors: dw 5                    ; 1 sector for stage - 1 and 4 sector for stage - 2
bdb_no_of_fats:             db 2                    ; we'll have 2 file allocation tables
bdb_dir_entries_count:      dw 0x0E0                ; 0x0E0 = 224 which standard size for 1.44 mb floppy
bdb_total_sectors:          dw 2880                 ; 2880 * 512 = 1.44 mb
bdb_media_descriptor_type:  db 0x0F0                ; F0 = 3.5" floppy disk
bdb_sectors_per_fat:        dw 9                    ; 9 sectors/fat
bdb_sectors_per_track:      dw 18
bdb_heads:                  dw 2
bdb_hidden_sectors:         dd 0
bdb_large_sector_count:     dd 0

; extended boot record
ebr_drive_number:           db 0                        ; 0x00 floppy, 0x80 hdd, useless
                            db 0                        ; reserved
ebr_signature:              db 0x29
ebr_volume_id:              db 0x24, 0x11, 0x20, 0x03   ; serial number, value doesn't matter
ebr_volume_label:           db 'Madhav OS'              ; 11 bytes, padded with spaces
ebr_system_id:              db 'FAT12   '               ; 8 bytes

start:
    cli              ; no interrupts during setup refer the Readme under /Bootloader 
    cld              ; string ops go forward
    xor ax, ax       ; Set all segments to zero
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, STACK    ; Set stack
    mov bp, sp
    mov [ebr_drive_number], dl
    sti              ; enable interrupts after setup


    push 1
    push 4
    push STAGE_2_OFFSET
    call bios_read_disk

    jmp STAGE_2_OFFSET
    jmp hlt

; ------------------------------------------------------------
; ## bios_read_disk — provide the lba and get the sector at 
;                     provided memory location 
; ## Inputs(Stack): LBA, num of sectors, memory location 
; ## Outputs: load the LBA block at the memory location
; ------------------------------------------------------------
bios_read_disk:
    push bp 
    mov bp, sp
    pusha 
    
    push word [bp + 8]
    call lba_to_chs
    
    mov dl, [ebr_drive_number]
    xor ax, ax 
    mov es, ax              ; set extra segment as 0   
    mov bx, [bp + 4]        ; es:bx memory location 
    mov ah, 2               ; read mode
    mov al, [bp + 6]        ; number of sectors
    int 0x13

    popa
    pop bp
    ret 6

    
; ------------------------------------------------------------
; ## lba_to_chs — convert the lba to chs addressing, 
;                 assigning the registers  
; ## Inputs(Stack): LBA
; ## Outputs: set the registers for bios 0x13 disk int 
; ## Clobbers: ch, dh, cl 
; ------------------------------------------------------------
lba_to_chs:
    push bp 
    mov bp, sp

    mov ax, [bp + 4]
    xor dx, dx 
    div word [bdb_sectors_per_track]

    inc dx
    mov cl, dl                          ; sector number

    xor dx, dx                          ; clear dx previous remainder 
    div word [bdb_heads]                ; bx still has bdb_sectors_per_track
    
    mov dh, dl                          ; head number
    mov ch, al                          ; cylinder number
    shl ah, 6
    or cl, ah

    xor ax, ax
    pop bp
    ret 2

hlt: 
    jmp hlt

; %include "stage-1/test.asm"
times 510-($-$$) db 0
dw 0xaa55

