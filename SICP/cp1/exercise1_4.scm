(define (a-plus-abs-b a b)
   ((if (> b 0) + -) a b))

;上述的定义过程是一个求a与b的绝对值之和的过程
;在过程的body执行中，首先判断b的值是否大于0
;如果b大于0，就求解表达式(+ a b)的结果并将这个结果做为整个过程的结果
;如果b不大于0，就求解(- a b)的结果做为整个过程的结果