[org 0x7c00]    ; this is where the boot loader is started
[bits 16]       ; tell the nasm that we are in 16 bits real mode 
STACK equ 0x9000

start:
    cli              ; no interrupts during setup refer the Readme under /Bootloader 
    cld              ; string ops go forward
    xor ax, ax       ; Set all segments to zero
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, STACK    ; Set stack
    mov sp, bp

    ; clear the screen 
    call clear_screen

    ; load the intro in the memory
    xor ax, ax 
    mov es, ax       ; set extra segment as 0   
    mov bx, 0x7e00   ; 512 bytes after 0x7c00
    mov ah, 2        ; read mode
    mov al, 1        ; number of sectors
    mov ch, 0        ; cylinder number
    mov cl, 2        ; sector number 
    mov dh, 0        ; head number
    int 0x13

    ; print it 
    call print_text_art


jmp $ 
%include "./Bootloader/utils/print.asm"
times 510-($-$$) db 0
dw 0xaa55
%include "./Bootloader/stage-1/intro.asm"

