# === CONFIG ===
ASM=nasm #the assembler nasm
ASM_FLAGS=-f bin #raw 512 bytes bootloader must be pure machine code, not wrapped in ELF or PE formats 
QEMU=qemu-system-x86_64 
TIMESTAMP := $(shell date +"%Y-%m-%d_%H-%M-%S")

# Allow specifying source file like: make F=boot.asm
F ?=Bootloader/stage-1/boot.asm
BOOT_BIN := bin/$(basename $(notdir $(F))).bin

# === TARGETS ===
# first clean the bin directory then, assemble the bin and run it using qemu 
all: clean $(BOOT_BIN) run
debug: clean $(BOOT_BIN) run_debug

$(BOOT_BIN): $(F)
	@mkdir -p bin
	$(ASM) $(ASM_FLAGS) -o $(BOOT_BIN) $(F)

run: $(BOOT_BIN)
	$(QEMU) -drive format=raw,file=$(BOOT_BIN)

run_debug: $(BOOT_BIN)
	@mkdir -p debug/logs
	$(QEMU) -drive format=raw,file=$(BOOT_BIN) -S -s -D ./debug/logs/logs_$(TIMESTAMP).log

clean:
	rm -rf bin
