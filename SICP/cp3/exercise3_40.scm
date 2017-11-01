#lang sicp

(define x 10)
(parallel-execute (lambda () (set! x (* x x)))
                  (lambda () (set! x (* x x x))))

; 可能产生的结果
; 1,000,000 -> P1 执行完，P2 执行或者 P2 执行完，P1 执行
; 10,000    -> P1 执行乘法的过程中，两个乘数之一的 x 值被 P2 改变
; 100,000   -> P2 执行过程中，后两个因子 x 值被 P1 修改
; 10,000    -> P2 执行过程中，最后一个因子 x 值被 P1 修改
; 100       -> P1 先读取了 x 的初始值，然后 P2 执行完，P1 最后完成写入
; 1000      -> P2 先读取了 x 的初始值，然后 P1 执行完，P2 最后完成写入


; 使用下面的串行化执行，只有第一种可能还会出现
; 1,000,000 -> P1 执行完，P2 执行或者 P2 执行完，P1 执行
(define s (make-serializer))
(parallel-execute (s (lambda () (set! x (* x x))))
                  (s (lambda () (set! x (* x x x)))))