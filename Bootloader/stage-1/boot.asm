[org 0x7c00] ; this is where the boot loader is started
[bits 16] ; tell the nasm that we are in 16 bits real mode 


mov bp, 0x9000
mov sp, bp
push string
call print
jmp $
%include "./utils/print.asm"
string:
    db "Hello, World!", 0
times 510-($-$$) db 0
dw 0xaa55

