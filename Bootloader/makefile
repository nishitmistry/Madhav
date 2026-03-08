Boot_Build = $(BUILD_DIR)/Bootloader

all: always linking

always: 
	@mkdir -p $(Boot_Build)
	
linking: stage1 stage2
	@echo "Linking the stage1 and stage2 file"
	cat $(Boot_Build)/stage1.bin $(Boot_Build)/stage2.bin  > $(BUILD_DIR)/boot.bin


stage1:$(Boot_Build)/stage1.o
$(Boot_Build)/stage1.o:
	@echo "Creating stage1.o file"
	$(ASM) $(ASM_FLAGS) -o $(Boot_Build)/stage1.bin stage-1/main.asm

stage2:$(Boot_Build)/stage2.o
$(Boot_Build)/stage2.o:
	@echo "Creating stage2.o file"
	$(ASM) $(ASM_FLAGS) -o $(Boot_Build)/stage2.bin  stage-2/main.asm
