include config.mk
export

.PHONY: all always bootloader run debug_run

# === TARGETS ===
# first clean the bin directory then, assemble the bin 
# into a floppy image  and run it using qemu 
all: always floppy_image run

debug: always floppy_image debug_run

debug_run:
	bochs -f bochs_config


floppy_image: $(BUILD_DIR)/main_floppy.img

$(BUILD_DIR)/main_floppy.img: bootloader
# block size = 512 bytes count = 2880 so therefore the size cames to 
# 1.44MB which is the standard size of 3.5-inch floppy disk
	dd if=/dev/zero of=$(BUILD_DIR)/main_floppy.img bs=512 count=2880
# formating the floppy image is not required as we have specified the fat flags in the stage-1 file
# 	newfs_msdos -F 12 -f 1440 disk12
	dd if=$(BUILD_DIR)/boot.bin of=$(BUILD_DIR)/main_floppy.img conv=notrunc
# 	mcopy -i $(BUILD_DIR)/main_floppy.img $(BUILD_DIR)/stage2.bin "::stage2.bin"
# 	cp $(BOOT_BIN) $(BUILD_DIR)/main_floppy.img
#  has  so we pad the remaining space
# 	truncate -s 1440k $(BUILD_DIR)/main_floppy.img

bootloader:
	@$(MAKE) -C Bootloader


run: floppy_image
	$(QEMU) -drive format=raw,file=$(BUILD_DIR)/main_floppy.img


always:
	@echo "Clearing the /BIN Folder."
	@rm -rf $(BUILD_DIR)
	@mkdir -p $(BUILD_DIR)