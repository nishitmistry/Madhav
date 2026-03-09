%include "constants.asm"
[org STAGE_2_OFFSET]
stage_2:
    call clear_screen
    call print_text_art
    ret


%include "stage-2/intro.asm"
%include "stage-2/print.asm"
