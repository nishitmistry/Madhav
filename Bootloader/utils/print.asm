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
    mov ah, 0x0e       ; tty mode
    mov bp, sp
    mov bx, [bp + 2]   ; fetch top data of the stack along with skiping the return address 
    mov si, bx

.print_loop:
    lodsb              ; AL = [DS:SI], SI++
    cmp al, 0
    je .end_print_func
    int 0x10 
    jmp .print_loop

.end_print_func:
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
    mov ah, 0x0e       ; tty mode 
    mov al, CR
    int 0x10
    mov al, LF
    int 0x10
    ret
    



    

