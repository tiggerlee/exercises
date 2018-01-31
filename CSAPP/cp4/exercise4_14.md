# exercise 4.14

阶段       | 通用                      | 具体
-----------|--------------------------|-----------------
 -         | popq rA                  | popq %rax 
 取指       | icode:ifun <- M1[PC]     | icode:ifun <- M1[0x02C] = B:0
 -         | rA:rB <- M1[PC+1]        | rA:rB <- M1[0x02D] = 0:F
 -         | valP <- PC+2             | valP <- 0x02C + 2 = 0x02E
 译码       | valA <- r[%rsp]          | valA <- r[%rsp] = 120
 译码       | valB <- r[%rsp]          | valB <- r[%rsp] = 120
 执行       | valE <- valB + 8         | valE <- valB + 8 = 120 + 8 = 128
 访存       | valM <- M8[valA]         | valM <- M8[120] = 9
 写回       | R[%rsp] <- valE          | r[%rsp] <- valE = 128
 写回       | R[rA] <- valM            | r[%rax] <- valM = 9
 更新PC     | PC <- valP               | PC <- valP = 0x02E