# exercise 4.14

阶段       | 通用                      | 具体
-----------|--------------------------|-----------------
 -         | call dest                | call 0x041 
 取指       | icode:ifun <- M1[PC]     | icode:ifun <- M1[0x037] = 8:0
 -         | valC <- M8[PC+1]         | valC <- M8[0x038] = 0x041
 -         | valP <- PC+9             | valP <- 0x037 + 9 = 0x040
 译码       | valB <- r[%rsp]          | valB <- r[%rsp] = 128
 执行       | valE <- valB + -8        | valE <- valB + 8 = 128 - 8 = 120
 访存       | M8[valE] <- valP         | M8[120] <- = 0x040
 写回       | R[%rsp] <- valE          | r[%rsp] <- valE = 120
 更新PC     | PC <- valC               | PC <- valC = 0x041