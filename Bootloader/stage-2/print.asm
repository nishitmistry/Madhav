%include "./Bootloader/constants.asm"
; ------------------------------------------------------------
; ## Function: print
;
; ## Description:
;   - It print the chars passed in the stack before calling using bios interupts.
;
; ## Inputs:
;   - Stack argument (string memory address terminated by null).
;
; ## Outputs:
;   - void
;
; ## Clobbers:
;   - ax, bx
;
; ## Notes:
;   - this function chean the stack
; ------------------------------------------------------------
print:
    push bp             ; Save the old base pointer
    mov bp, sp
    pusha
    mov ah, 0x0e       ; tty mode
    mov bx, [bp + 4]   ; fetch top data of the stack along with skiping the return address and base pointer 
    mov si, bx

.print_loop:
    lodsb              ; AL = [DS:SI], SI++
    cmp al, 0
    je .end_print_func
    int 0x10 
    jmp .print_loop

.end_print_func:
    popa
    pop bp 
    ret 2              ; return and also remove the arguments pushed on the stack 

; ------------------------------------------------------------
; ## Function: print_nl
;
; ## Description:
;   - print new line CRLF form, using bios interupts.
;
; ## Clobbers:
;   - ax
; ------------------------------------------------------------
print_nl:
    pusha
    mov ah, 0x0e       ; tty mode 
    mov al, CR
    int 0x10
    mov al, LF
    int 0x10
    popa
    ret

; ------------------------------------------------------------
; ## Function: clear_screen
;
; ## Description:
;   - clears the sceen using 0x10 bios interupt
; ------------------------------------------------------------
clear_screen:
    pusha

    mov ax, 0x0600   ; AH=06h (scroll), AL=0 (clear)
    mov bh, 0x07     ; attribute: light gray on black
    mov cx, 0x0000   ; top-left corner (row 0, col 0)
    mov dx, 0x184F   ; bottom-right (row 24, col 79)
    int 0x10

    mov ah, 0x02
    mov bh, 0x00
    mov dh, 0x00        ; row
    mov dl, 0x00        ; column
    int 0x10

    popa
    ret

    



    

