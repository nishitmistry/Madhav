%include "stage-2/strings.asm"
print_text_art:
    push bios_intro
    call print
    ret