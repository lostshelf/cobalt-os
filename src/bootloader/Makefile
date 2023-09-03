BUILD_DIR := ../../build/bootloader

BOOTLOADER_ASM_FILES := $(wildcard *.asm)
BOOTLOADER_OBJ_FILES := $(patsubst %.asm, $(BUILD_DIR)/%.o, $(BOOTLOADER_ASM_FILES))
BOOTLOADER_EXEC_FILES := $patsubst %.asm, $(BUILD_DIR)/%, $(BOOTLOADER_OBJ_FILES))

all: $(BOOTLOADER_OBJ_FILES)

$(BUILD_DIR)/%.o: %.asm
	@nasm -f elf $< -F dwarf -g -o $@
	@ld -m elf_i386 $@ -o $@

clean:
	@rm $(BUILD_DIR)/*
