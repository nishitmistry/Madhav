; ------------------------------------------------------------
; ## Function: print
;
; ## Description:
;   - It print the chars passed in the stack before calling.
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
    ret 2              ; remove the arguments pushed on the stack 

    

