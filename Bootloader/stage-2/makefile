TARGET_LINKFLAGS += -T linker.ld
STAGE_2_BUILD = $(BOOT_BUILD)/stage-2

SOURCES_ASM=$(wildcard *.asm)
SOURCES_C=$(wildcard *.c)
OBJECTS_ASM=$(patsubst %.asm, $(STAGE_2_BUILD)/asm/%.obj, $(SOURCES_ASM))
OBJECTS_C=$(patsubst %.c, $(STAGE_2_BUILD)/c/%.obj, $(SOURCES_C))



all: stage2

stage2: $(STAGE_2_BUILD)/stage2.bin
$(STAGE_2_BUILD)/stage2.bin: $(OBJECTS_ASM) $(OBJECTS_C)
	@$(TARGET_LD) $(TARGET_LINKFLAGS) -Wl,-Map=$(STAGE_2_BUILD)/stage2.map -o $@ $^ $(TARGET_LIBS)
	@echo "--> Created  stage2.bin"

$(STAGE_2_BUILD)/c/%.obj: %.c
	@mkdir -p $(@D)
	@$(TARGET_CC) $(TARGET_CFLAGS) -c -o $@ $<
	@echo "--> Compiled: " $<
	

$(STAGE_2_BUILD)/asm/%.obj: %.asm
	@mkdir -p $(@D)
	@$(TARGET_ASM) $(TARGET_ASMFLAGS) -o $@ $<
	@echo "--> Compiled: " $<