#lang sicp

(define x 10)
(define s (make-serializer))
(parallel-execute (lambda () (set! x ((s (lambda () (* x x))))))
                  (s (lambda () (set! x (+ x 1)))))

; 第一种和第二种还可能出现，后三种不会出现
; P2现在的计算是不可分割的，所以第四种排除
; P1 的计算部分和获取 x 值的部分是不可分割的，所以第三种和第五种排除

; 101: P1 sets x to 100 and then P2 increments x to 101.
; 121: P2 increments x to 11 and then P1 sets x to x times x.
; 110: P2 changes x from 10 to 11 between the two times that P1 accesses the value of x during the evaluation of (* x x).
; 11: P2 accesses x, then P1 sets x to 100, then P2 sets x.
; 100: P1 accesses x (twice), then P2 sets x to 11, then P1 sets x.