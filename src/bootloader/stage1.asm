[bits 16]
[org 0x7c00]

_start:
    cli

    ; Can't set DS and ES directly.
    xor ax, ax
    mov ds, ax 
    mov es, ax

    ; 0x5000 is a relatively safe area in memory. No other code is going to be touching it besides me
    mov ax, 0x0500 ; Can't move values directly into SS, need to use some other register first
    mov ss, ax
    ; Not 0xFFFF as that would mess up the alignment
    mov sp, 0xFFFE

    ; Load second stage into memory
    mov ah, 0x2    ; No idea why is 0x2 but that's what Ralph Brown is telling me to do 
    mov al, 0x1    ; Number of sectors to read. I only want 1.
    mov ch, 0x0    ; Low eight bits of cylinder number. No idea what this is supposed to be so I'm praying this is okay.
    mov cl, 0x2    ; Sector number (I want the second sector which contains the second stage bootloader)
    mov dh, 0x0    ; Head number 
    mov bx, 0x8000 ; Where to store the data (Uses ES for the segment which is already set to 0)
    int 0x13

    jc .disk_error

    mov ah, 0x9
    mov al, 0x58
    mov bh, 0x0
    mov bl, 0b0111
    mov cx, 0x0
    int 0x10

    ; Jump to the second stage bootloader
    jmp 0x8000

.disk_error:
    mov ah, 0x9
    mov al, 0x59
    mov bh, 0x0
    mov bl, 0b111
    mov cx, 0x1
    int 0x10
    hlt

; Fill the remaining boot sector with 0s
times 510-($-$$) db 0

; Magic number which specifies this is a boot sector
dw 0xAA55
