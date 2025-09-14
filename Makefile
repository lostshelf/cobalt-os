# Tools
ASM = nasm
CC = clang
LD = ld
OBJCOPY = objcopy

# Flags
ASMFLAGS = -f bin
CFLAGS = -ffreestanding -O2 -Wall -Wextra -g
LDFLAGS = -m elf_i386

# Paths
BOOTLOADER = src/boot
STAGE1 = $(BOOTLOADER)/stage1
STAGE2 = $(BOOTLOADER)/stage2
KERNEL = src/kernel
BUILD = build
NASM_INC = $(BOOTLOADER)/common

# Files
STAGE1_SRC = $(STAGE1)/stage1.asm
STAGE1_BIN = $(BUILD)/stage1.bin
STAGE1_ELF = $(BUILD)/stage1.elf
STAGE1_LD = $(STAGE1)/stage1.ld

STAGE2_SRC = $(STAGE2)/stage2.asm
STAGE2_ELF = $(BUILD)/stage2.elf
STAGE2_BIN = $(BUILD)/stage2.bin
STAGE2_LD  = $(STAGE2)/stage2.ld

KERNEL_SRC = $(KERNEL)/kernel.c
KERNEL_BIN = $(BUILD)/kernel.bin
KERNEL_LD = $(KERNEL)/kernel.ld
KERNEL_ELF = $(BUILD)/kernel.elf

OS_IMAGE = $(BUILD)/cobalt-os.bin

# Default target
all: $(OS_IMAGE)

# Stage1
$(STAGE1_ELF): $(STAGE1_SRC)
	@mkdir -p $(BUILD)
	$(ASM) -f elf32 -I $(NASM_INC) -g $< -o $(BUILD)/stage1.o
	$(LD) $(LDFLAGS) -T $(STAGE1_LD) $(BUILD)/stage1.o -o $@

$(STAGE1_BIN): $(STAGE1_ELF)
	@mkdir -p $(BUILD)
	objcopy -O binary $< $@

# Stage2
$(STAGE2_ELF): $(STAGE2_SRC)
	@mkdir -p $(BUILD)
	$(ASM) -f elf32 -g -I $(NASM_INC) $< -o $(BUILD)/stage2.o
	$(LD) $(LDFLAGS) -T $(STAGE2_LD) $(BUILD)/stage2.o -o $@

$(STAGE2_BIN): $(STAGE2_ELF)
	@mkdir -p $(BUILD)
	objcopy -O binary $< $@

# Kernel
$(KERNEL_ELF): $(KERNEL_SRC)
	@mkdir -p $(BUILD)
	$(CC) $(CFLAGS) -m32 -c $< -o $(BUILD)/kernel.o
	$(LD) -T $(KERNEL_LD) $(LDFLAGS) $(BUILD)/kernel.o -o $@

$(KERNEL_BIN): $(KERNEL_ELF)
	@mkdir -p $(BUILD)
	objcopy -O binary $< $@ 

# Final OS image
$(OS_IMAGE): $(STAGE1_BIN) $(STAGE2_BIN) $(KERNEL_BIN)
	cat $^ > $@

# Clean
clean:
	rm -rf $(BUILD)

debug: $(OS_IMAGE) $(STAGE1_ELF) $(STAGE2_ELF) $(KERNEL_ELF)
	qemu-system-i386 -fda $< -S -gdb tcp::1234

run: $(OS_IMAGE)
	qemu-system-i386 -drive format=raw,file=$<

.PHONY: all clean
