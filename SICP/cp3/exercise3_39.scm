#lang sicp

(define x 10)
(define s (make-serializer))
(parallel-execute (lambda () (set! x ((s (lambda () (* x x))))))
                  (s (lambda () (set! x (+ x 1)))))

; 第一种和第二种还有第五种还可能出现
; 第一种和第二种是按照两个进程按照顺序执行完的结果，所以是可能出现的。
; 第三种由于 P1 计算和访问部分(lambda () (* x x))现在至于串行化执行集合中，不会出现计算和赋值分离执行，不可能出现
; 第四种由于 P2 计算和赋值过程不能分离执行，所以不可能出现
; 第五种出现的条件是 P1 获取 x 并计算 (* x x)，然后 P2 执行，将 x 设置为11，然后 P1 将之前计算的结果11设置为 x 最后的值

; 101: P1 sets x to 100 and then P2 increments x to 101.
; 121: P2 increments x to 11 and then P1 sets x to x times x.
; 110: P2 changes x from 10 to 11 between the two times that P1 accesses the value of x during the evaluation of (* x x).
; 11: P2 accesses x, then P1 sets x to 100, then P2 sets x.
; 100: P1 accesses x (twice), then P2 sets x to 11, then P1 sets x.