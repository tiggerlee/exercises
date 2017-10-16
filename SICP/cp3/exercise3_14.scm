#lang sicp

(define (mystery x)
  (define (loop x y)
    (if (null? x)
        y
        (let ((temp (cdr x)))
          (set-cdr! x y)
          (loop temp x))))
  (loop x '()))

(define v (list 'a 'b 'c 'd))
(define w (mystery v))
; (mystery (a b c d))
; (loop (a b c d) '())
; (loop (b c d) (a))
; (loop (c d) (b a))
; (loop (d) (c b a))
; (loop () (d c b a))
; (a b c d)
; 通过对执行过程的分析，可以得到 mystery 和 reverse实现了相同的功能
; 盒子模型参考 http://sicp.readthedocs.io/en/latest/chp3/14.html
w ; (d c b a)
v ; (a)