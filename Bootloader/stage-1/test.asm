
test:
    call .test_lba_to_chs

.test_lba_to_chs:
    push 100
    call lba_to_chs
    cmp cl, 11
    jne .test_lba_to_chs_failed
    cmp ch, 2
    jne .test_lba_to_chs_failed
    cmp dh, 1
    jne .test_lba_to_chs_failed

    push 1500
    call lba_to_chs
    cmp cl, 7
    jne .test_lba_to_chs_failed
    cmp ch, 41
    jne .test_lba_to_chs_failed
    cmp dh, 1
    jne .test_lba_to_chs_failed

    push 751
    call lba_to_chs
    cmp cl, 14
    jne .test_lba_to_chs_failed
    cmp ch, 20
    jne .test_lba_to_chs_failed
    cmp dh, 1
    jne .test_lba_to_chs_failed
    ret
    

.test_lba_to_chs_failed:
    push ref_file
    call print
    push lba_test_failed
    call print
    jmp hlt

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

ref_file: db "main.asm :", 0
lba_test_failed: db "lba to chs test failed", 0
