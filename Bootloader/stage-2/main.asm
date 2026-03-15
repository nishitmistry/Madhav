%include "../constants.asm"

extern clear_screen
extern print_text_art
extern Enter_32_protected
global stage_2
section .entry
stage_2:
    [bits 16]
    call clear_screen
    call print_text_art
    jmp Enter_32_protected
    ret