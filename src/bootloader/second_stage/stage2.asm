[org 0x8000]
[bits 16]

_stage2:
    ; Get memory map
    xor ax, ax
    mov es, ax
    mov di, 0x9000
    xor ebx, ebx
    mov edx, 0x534D4150
    mov eax, 0xE820
    mov ecx, 24
    int 0x15

    
