extern print
extern bios_intro
global print_text_art
print_text_art:
    [bits 16]
    push bios_intro
    call print
    ret