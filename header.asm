; Epsilon, 2017
; Restart vectors are ugly and are not used here. If the PC comes across an RST vector, hang the game
SECTION "Restart1",HOME[$00]
rst $38
SECTION "Restart2",HOME[$08]
rst $38
SECTION "Restart3",HOME[$10]
rst $38
SECTION "Restart4",HOME[$18]
rst $38
SECTION "Restart5",HOME[$20]
rst $38
SECTION "Restart6",HOME[$28]
rst $38
SECTION "Restart7",HOME[$30]
rst $38
SECTION "Restart8",HOME[$38]
rst $38 ; lol
SECTION "InitialStart",HOME[$100] ; Game jumps here on boot
di ; Disable interupts, having them happen during init is a no-no
jp start ; Jump to initialization. Long jump 'cuz there's an extra byte
rept $150 - $104
db $00 ; Initialize header for RGBFIX
endr
SECTION "Vblank",HOME ; Le VBLANK Interupt
push af
push hl
push de
push bc ; Preserve registers
call spriteupdate ; useful because sprites can only be updated during Vblank anyhow
pop bc
pop de
pop hl
pop af ; Replace preserved registers
reti ; Return, with interupts if disabled (They shouldn't be disabled)
