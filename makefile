# === CONFIG ===
ASM=nasm #the assembler nasm
ASM_FLAGS=-f bin #raw 512 bytes bootloader must be pure machine code, not wrapped in ELF or PE formats 
QEMU=qemu-system-x86_64 

# Allow specifying source file like: make F=boot.asm
F ?=Bootloader/stage-1/boot.asm
BOOT_BIN := bin/$(basename $(notdir $(F))).bin

# === TARGETS ===

all: clean $(BOOT_BIN) run

$(BOOT_BIN): $(F)
	@mkdir -p bin
	$(ASM) $(ASM_FLAGS) -o $(BOOT_BIN) $(F)

run: $(BOOT_BIN)
	$(QEMU) -drive format=raw,file=$(BOOT_BIN)

clean:
	rm -rf bin
