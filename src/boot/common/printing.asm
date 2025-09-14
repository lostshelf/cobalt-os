; Put the character to print into AL
print_char:
    pusha

    mov ah, 0x8
    mov bh, 0x0
    mov bl, 0x7
    mov cx, 0x1
    int 0x10

    popa
    ret

print_str:
    pusha

    popa
    ret
