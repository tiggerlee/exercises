#lang sicp

(define (a-plus-abs-b a b)
   ((if (> b 0) + -) a b))

;a-plus-abs-b 是要给求 a 和 b 的绝对值和的方法
;判断b是否大于0
;如果b大于0，将表达式(+ a b)的结果作为方法的最终结果
;否则将(- a b)的结果作为方法的最终结果

(a-plus-abs-b 3 -4)    ; (- 3 -4) = 7
(a-plus-abs-b 3 4)     ; (+ 3 4) = 7
(a-plus-abs-b 3 0)     ; (+ 3 0) = 3
(a-plus-abs-b -4 -3)   ; (- -4 -3) = -1
(a-plus-abs-b -4 3)    ; (+ -4 3) = -1