ENTRY(_stage2)
SECTIONS {
    . = 0x8000;       /* load Stage 2 at 0x7E00 */
    .text : { *(.text) }
}