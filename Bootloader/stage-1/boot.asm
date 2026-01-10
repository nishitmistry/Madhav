[org 0x7c00] ; this is where the boot loader is started
[bits 16] ; tell the nasm that we are in 16 bits real mode 
STACK equ 0x9000

start:
    xor ax, ax       ; Set all segments to zero
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, STACK    ; Set stack to guarantee data safety
    call print_text_art

jmp $
%include "./utils/print.asm"
%include "./Bootloader/strings.asm"
%include "./Bootloader/stage-1/intro.asm"
times 510-($-$$) db 0
dw 0xaa55

