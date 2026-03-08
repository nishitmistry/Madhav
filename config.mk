# === CONFIG ===
ASM=nasm #the assembler nasm
ASM_FLAGS=-f bin  #raw 512 bytes bootloader must be pure machine code, not wrapped in ELF or PE formats 
QEMU=qemu-system-x86_64 
BUILD_DIR=$(ROOT_DIR)/bin
ROOT_DIR := $(CURDIR)