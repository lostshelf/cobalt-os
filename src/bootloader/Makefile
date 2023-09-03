BUILD_DIR := ../../build/bootloader

ASM_FILES := $(wildcard *.asm)
OBJ_FILES := $(patsubst %.asm, $(BUILD_DIR)/%.o, $(ASM_FILES))
EXEC_FILES := $(patsubst $(BUILD_DIR)/%.o, $(BUILD_DIR)/%, $(OBJ_FILES))

all: $(EXEC_FILES)

$(OBJ_FILES): $(ASM_FILES)
	@nasm -f elf $< -F dwarf -g -o $@

$(EXEC_FILES): $(OBJ_FILES)
	@ld -Ttext 0x7c00 -m elf_i386 $< -o $@
	
clean:
	@rm $(BUILD_DIR)/*
