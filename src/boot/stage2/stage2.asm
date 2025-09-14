[bits 16]
global _stage2

_stage2:
    mov ah, 0x9
    mov al, 0x59
    mov bh, 0x0
    mov bl, 0b0111
    mov cx, 0x0
    int 0x10

    ; Get memory map
    xor ax, ax
    mov es, ax
    mov di, 0x9000
    xor ebx, ebx
    mov edx, 0x534D4150
    mov eax, 0xE820
    mov ecx, 24
    int 0x15

    
