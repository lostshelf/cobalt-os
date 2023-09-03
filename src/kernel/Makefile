BUILD_DIR := ../../build/kernel

COMPILER_FLAGS += -ffreestanding -nostdlib -gdwarf-4 -m32 -ggdb3

SRC_FILES := $(wildcard *.c)
HEADER_FILES := $(wildcard *.h)
OBJ_FILES := $(patsubst %.c, $(BUILD_DIR)/%.o, $(SRC_FILES))
EXEC_FILES := $(patsubst $(BUILD_DIR)/%.o, $(BUILD_DIR)/%, $(OBJ_FILES))

all: $(EXEC_FILES)

$(OBJ_FILES): $(SRC_FILES)
	@gcc $(COMPILER_FLAGS) -c $< -o $@

$(EXEC_FILES): $(OBJ_FILES)
	@ld -m elf_i386 $< -o $@

clean:
	@rm $(OBJ_FILES)
	@rm $(EXEC_FILES)