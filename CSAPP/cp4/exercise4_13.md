# exercise 4.13

阶段       | 通用                      | 具体
-----------|--------------------------|-----------------
 -         | irmovq V, rB             | irmovq $128, %rsp
 取指       | icode:ifun <- M1[PC]     | icode:ifun <- M1[0x016] = 3:0
 -         | rA:rB <- M1[PC+1]        | rA:rB <- M1[0x017] = F:4
 -         | valC <- M8[PC+2]         | valC <- M8[0x108] = 0x80
 -         | valP <- PC+10            | valP <- 0x016 + 10 = 0x020
 译码       | -                        | -
 执行       | valE <- 0+valC           | valE <- 0+0x80 = 0x80
 访存       | -                        | -
 写回       | R[rB] <- valE            | r[%rsp] <- valE = 0x80
 更新PC     | PC <- valP               | PC <- valP = 0x020