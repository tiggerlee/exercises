A. 0x100: 30 F3 FC FF FF FF FF FF FF FF 40 63 00 08 00 00 00 00 00 00
0x100: 30 F3 FC FF FF FF FF FF FF FF | irmovq $-4, %rbx
0x10A: 40 63 00 08 00 00 00 00 00 00 | rmmovq %rsi, 0x800(%rbx)

B. 0x200: A0 6F 80 0C 02 00 00 00 00 00 00 00 30 F3 0A 00 00 00 00 00 00 00 90
0x200: A0 6F                         | pushq %rsi
0x202: 80 0C 02 00 00 00 00 00 00    | call proc
0x20B: 00                            | halt
0x20C:                               | proc:
0x20C: 30 F3 0A 00 00 00 00 00 00 00 | irmovq $10, %rbx
0x216: 90                            | ret 

C. 0x300: 50 54 07 00 00 00 00 00 00 00 10 F0 B0 1F
0x300: 50 54 07 00 00 00 00 00 00 00 | mrmovq 7(%rsp), %rbp
0x30A: 10                            | nop
0x30B: F0                            | // 不合法，没有 F0 这个指令的编码

D. 0x400: 61 13 73 00 04 00 00 00 00 00 00 00
0x400:                            | loop:
0x400: 61 13                      | subq %rcx, %rbx
0x402: 73 00 04 00 00 00 00 00 00 | je loop 
0x40B: 00                         | halt

E. 0x500: 63 62 A0 F0
0x500: 63 62 | xorq %rsi, %rdx
0x502: A0 F0 | F0不合法，A0 是 pushq 指令，后面接一个寄存器名称和一个F格式的字节，例如 3F