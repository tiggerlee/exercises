.pos 0x100
0x100: irmovq $15, %rbx       | 0x100: 30 F3 0F 00 00 00 00 00 00 00
       rrmovq %rbx, %rcx      | 0x10A: 20 31
loop:
       rmmovq %rcx, -3(%rbx)  | 0x10C: 40 13 FD FF FF FF FF FF FF FF
       addq %rbx, %rcx        | 0x116: 60 31
       jmp loop               | 0x118: 70 0C 01 00 00 00 00 00 00 00