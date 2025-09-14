; Assume AL already has the character to be printed
print_char:
    pusha

    mov ah, 0x8 ; BIOS Function
    mov bh, 0x0 ; Page number or smthn im forgetting
    mov bl, 0x7 ; Formatting code
    mov cx, 0x1 ; Amount of characters to print
    int 0x10 ; BIOS Interrupt

    popa
    ret

print_str:
    pusha

    popa
    ret
