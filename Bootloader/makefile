export BOOT_BUILD = $(BUILD_DIR)/Bootloader
export BOOT_DIR = $(ROOT_DIR)/Bootloader

.PHONY: all always stage1 stage2

all: always linking

always: 
	@mkdir -p $(BOOT_BUILD)
	
linking: stage1 stage2
	@echo "Linking the stage1 and stage2 file"
	cat $(BOOT_BUILD)/stage-1/stage1.bin $(BOOT_BUILD)/stage-2/stage2.bin  > $(BUILD_DIR)/boot.bin


stage1:
	@$(MAKE) -C stage-1

stage2:
	@$(MAKE) -C stage-2
