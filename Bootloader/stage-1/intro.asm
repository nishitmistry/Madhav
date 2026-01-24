%include "./Bootloader/stage-1/strings.asm"
print_text_art:
    push bios_intro
    call print
    ret