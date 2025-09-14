ENTRY(main)

SECTIONS {
    /* Kernel load address (say 0x1000 for now) */
    . = 0x1000;

    .text : {
        *(.text)
    }

    .rodata : {
        *(.rodata*)
    }

    .data : {
        *(.data)
    }

    .bss : {
        *(.bss)
        *(COMMON)
    }
}