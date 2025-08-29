[bits 16]
[org 0x7c00]

main:
    jmp $

times 510-($-$$) db 0
dw 0xAA55
