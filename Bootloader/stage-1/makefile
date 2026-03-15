STAGE_1_BUILD = $(BOOT_BUILD)/stage-1
all: stage1

stage1:$(STAGE_1_BUILD)/stage1.bin
$(STAGE_1_BUILD)/stage1.bin:
	@mkdir -p $(@D)
	$(TARGET_ASM) -f bin -o $(STAGE_1_BUILD)/stage1.bin  main.asm
	@echo "--> Compiled:  main.asm"
	