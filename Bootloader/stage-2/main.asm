%include "constants.asm"
[org STAGE_2_OFFSET]
[bits 16]
stage_2:
    call clear_screen
    call print_text_art
    call Enter_32_protected
    ret

%include "stage-2/32bit.asm"
%include "stage-2/intro.asm"
%include "stage-2/print.asm"
