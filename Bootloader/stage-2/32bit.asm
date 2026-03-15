%include "../constants.asm"
extern print
extern c_start
extern __bss_start
extern __end
global Enter_32_protected
Enter_32_protected:
    [bits 16]
    cli                 ; step - 1 disable the interrupts
    call EnableA20     ; step - 2 Enable the A20 line
    call LoadGDT        ; step - 3 Load the GDT

    ; step 4 - set protection enable flag in CR0
    mov eax, cr0
    or al, 1
    mov cr0, eax

    ; step 5 - far jump into protected mode
    jmp dword 08h:.pmode

.pmode:
    ; we are now in protected mode!
    [bits 32]
    
    ; step 6 - setup segment registers
    mov ax, 0x10
    mov ds, ax
    mov ss, ax

    ; step 7 - clear all the data in the bss section 
    call .zero_bss
    call c_start
    cld

.zero_bss:
    mov edi, __bss_start
    mov ecx, __end
    sub ecx, edi          ; byte count
    xor eax, eax
    rep stosb             ; fill with zeros
    ret

.halt:
    jmp .halt


    
EnableA20:
    [bits 16]
    pusha

    call .checkA20
	cmp ax, 1
    je .EnableA20done

    .EnableA20loop:
        call .enable_keyboard_controller_a20
        call .checkA20
	    cmp ax, 1
        jne .EnableA20loop

    .EnableA20done:
        popa
        ret

.checkA20:
    [bits 16]
    pushf
    push si
	push di
    push ds
    push es

    xor ax, ax 
    mov ds, ax          ; assign the data segment as 0x0000

    mov ax, 0xFFFF
    mov es, ax          ; assign the extra segment as 0xffff

    mov si, 0x0500      ; ds:si --- 0x0000:0x0500 which translates to 0x000500 
    mov di, 0x0510      ; es:di --- 0xFFFF:0x0510 which translates to 0x100500  = 1MB + 500 

    mov ax, [es:di]
    push ax
    mov ax, [ds:si]
    push ax 

    mov byte [es:di], 0x00
    mov byte [ds:si], 0xff ; we assign value at ds:si which is 0x000500

    cmp word [es:di], 0xff   ; if the value at es:di which is 0x100500 is same as ds:si, 
                        ; we wrapped and the A20 line is disabled   
    je .A20_IS_Disabled
    jmp .A20_IS_Enabled



    .A20_IS_Enabled:
        push A20_ENABLED
        call print
        mov ax, 1
        jmp .Exit_A20_check

    
    .A20_IS_Disabled:
        push A20_DISABLED
        call print
        mov ax, 0

    .Exit_A20_check:
    pop word [ds:si]
    pop word [es:di]
    pop es
    pop ds
    pop di
    pop si
    popf

    ret

.enable_keyboard_controller_a20:
    ; ref https://github.com/nanobyte-dev/nanobyte_experiments/blob/master/ProtectedMode/src/main.asm
    [bits 16]
    push A20_KEYBOARD_WAY
    call print
    ; disable keyboard
    call A20WaitInput
    mov al, KbdControllerDisableKeyboard
    out KbdControllerCommandPort, al

    ; read control output port
    call A20WaitInput
    mov al, KbdControllerReadCtrlOutputPort
    out KbdControllerCommandPort, al

    call A20WaitOutput
    in al, KbdControllerDataPort
    push eax

    ; write control output port
    call A20WaitInput
    mov al, KbdControllerWriteCtrlOutputPort
    out KbdControllerCommandPort, al
    
    call A20WaitInput
    pop eax
    or al, 2                                    ; bit 2 = A20 bit
    out KbdControllerDataPort, al

    ; enable keyboard
    call A20WaitInput
    mov al, KbdControllerEnableKeyboard
    out KbdControllerCommandPort, al

    call A20WaitInput
    ret



A20WaitInput:
    [bits 16]
    ; wait until status bit 2 (input buffer) is 0
    ; by reading from command port, we read status byte
    in al, KbdControllerCommandPort
    test al, 2
    jnz A20WaitInput
    ret

A20WaitOutput:
    [bits 16]
    ; wait until status bit 1 (output buffer) is 1 so it can be read
    in al, KbdControllerCommandPort
    test al, 1
    jz A20WaitOutput
    ret


LoadGDT:
    [bits 16]
    lgdt [g_GDTDesc]
    ret

g_GDT:      ; NULL descriptor
            dq 0

            ; 32-bit code segment
            dw 0FFFFh                   ; limit (bits 0-15) = 0xFFFFF for full 32-bit range
            dw 0                        ; base (bits 0-15) = 0x0
            db 0                        ; base (bits 16-23)
            db 10011010b                ; access (present, ring 0, code segment, executable, direction 0, readable)
            db 11001111b                ; granularity (4k pages, 32-bit pmode) + limit (bits 16-19)
            db 0                        ; base high

            ; 32-bit data segment
            dw 0FFFFh                   ; limit (bits 0-15) = 0xFFFFF for full 32-bit range
            dw 0                        ; base (bits 0-15) = 0x0
            db 0                        ; base (bits 16-23)
            db 10010010b                ; access (present, ring 0, data segment, executable, direction 0, writable)
            db 11001111b                ; granularity (4k pages, 32-bit pmode) + limit (bits 16-19)
            db 0                        ; base high


g_GDTDesc:  dw g_GDTDesc - g_GDT - 1    ; limit = size of GDT
            dd g_GDT                    ; address of GDT




A20_ENABLED: dw " A20 Line Enabled", CR, LF, 0 
A20_DISABLED: dw " A20 Line is Disabled", CR, LF, 0
A20_KEYBOARD_WAY: dw " Enabling A20 Line through keyboard ", CR, LF, 0


KbdControllerDataPort               equ 0x60
KbdControllerCommandPort            equ 0x64
KbdControllerDisableKeyboard        equ 0xAD
KbdControllerEnableKeyboard         equ 0xAE
KbdControllerReadCtrlOutputPort     equ 0xD0
KbdControllerWriteCtrlOutputPort    equ 0xD1
ScreenBuffer                        equ 0xB8000
