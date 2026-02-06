%include "./Bootloader/stage-2/intro.asm"
%include "./Bootloader/stage-2/print.asm"
main:
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

