%include "../constants.asm"
[bits 16]
global bios_intro
bios_intro:
    db "  __  __             _  _                      ", CR, LF
    db " |  \/  |           | || |                     ", CR, LF
    db " | \  / |  __ _   __| || |__    __ _ __   __   ", CR, LF
    db " | |\/| | / _` | / _` || '_ \  / _` |\ \ / /   ", CR, LF
    db " | |  | || (_| || (_| || | | || (_| | \ V /    ", CR, LF
    db " |_|  |_| \__,_| \__,_||_| |_| \__,_|  \_/     ", CR, LF
    db CR, LF
    db " Bootloader Stage 2 Loaded From Stage 1 ", CR, LF 
    db " Created By - Nishit mistry", CR, LF
    db " Contact Creator - nishitmistry94@gmail.com", CR, LF, 0
