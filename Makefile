# Tools
ASM = nasm
CC = clang
LD = ld
OBJCOPY = objcopy

# Flags
ASMFLAGS = -f bin
CFLAGS = -ffreestanding -O2 -Wall -Wextra
LDFLAGS = -m elf_i386 -Ttext 0x1000

# Paths
BOOTLOADER = src/bootloader
STAGE2 = $(BOOTLOADER)/stage2
KERNEL = src/kernel
BUILD = build

# Files
STAGE1_SRC = $(BOOTLOADER)/stage1.asm
STAGE1_BIN = $(BUILD)/stage1.bin

STAGE2_SRC = $(STAGE2)/stage2.asm
STAGE2_BIN = $(BUILD)/stage2.bin
STAGE2_LD  = $(STAGE2)/stage2.ld

KERNEL_SRC = $(KERNEL)/kernel.c
KERNEL_BIN = $(BUILD)/kernel.bin

OS_IMAGE = $(BUILD)/cobalt-os.bin

# Default target
all: $(OS_IMAGE)

# Stage1
$(STAGE1_BIN): $(STAGE1_SRC)
	@mkdir -p $(BUILD)
	$(ASM) $(ASMFLAGS) $< -o $@

# Stage2
$(STAGE2_BIN): $(STAGE2_SRC)
	@mkdir -p $(BUILD)
	$(ASM) -f bin $< -o $(STAGE2_BIN)

# Kernel
$(KERNEL_BIN): $(KERNEL_SRC)
	@mkdir -p $(BUILD)
	$(CC) $(CFLAGS) -m32 -c $< -o $(BUILD)/kernel.o
	$(LD) $(LDFLAGS) $(BUILD)/kernel.o -o $@

# Final OS image
$(OS_IMAGE): $(STAGE1_BIN) $(STAGE2_BIN) $(KERNEL_BIN)
	cat $^ > $@

# Clean
clean:
	rm -rf $(BUILD)

.PHONY: all clean
