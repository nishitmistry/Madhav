# === CONFIG ===
ASM=nasm #the assembler nasm
ASM_FLAGS=-f bin #raw 512 bytes bootloader must be pure machine code, not wrapped in ELF or PE formats 
QEMU=qemu-system-x86_64 
BUILD_DIR=bin

# Allow specifying source file like: make F=boot.asm
F ?=Bootloader/stage-1/boot.asm
BOOT_BIN := $(BUILD_DIR)/$(basename $(notdir $(F))).bin

# === TARGETS ===
# first clean the bin directory then, assemble the bin and run it using qemu 
all: clean always floppy_image run

floppy_image: $(BUILD_DIR)/main_floppy.img

$(BUILD_DIR)/main_floppy.img: bootloader stage2
# block size = 512 bytes count = 2880 so therefore the size cames to 
# 1.44MB which is the standard size of 3.5-inch floppy disk
	dd if=/dev/zero of=$(BUILD_DIR)/main_floppy.img bs=512 count=2880
# formating the floppy image is not required as we have specified the fat flags in the stage-1 file
# 	newfs_msdos -F 12 -f 1440 disk12
	dd if=$(BOOT_BIN) of=$(BUILD_DIR)/main_floppy.img conv=notrunc
	mcopy -i $(BUILD_DIR)/main_floppy.img $(BUILD_DIR)/stage2.bin "::stage2.bin"
# 	cp $(BOOT_BIN) $(BUILD_DIR)/main_floppy.img
#  has  so we pad the remaining space
# 	truncate -s 1440k $(BUILD_DIR)/main_floppy.img

stage2: $(BUILD_DIR)/stage2.bin
$(BUILD_DIR)/stage2.bin : $(F)
	$(ASM) $(ASM_FLAGS) -o $(BUILD_DIR)/stage2.bin  Bootloader/stage-2/main.asm


run: floppy_image
	$(QEMU) -drive format=raw,file=$(BUILD_DIR)/main_floppy.img

bootloader: $(BOOT_BIN)

$(BOOT_BIN): $(F)
	$(ASM) $(ASM_FLAGS) -o $(BOOT_BIN) $(F)

always: 
	mkdir -p $(BUILD_DIR)

clean:
	rm -rf $(BUILD_DIR)
