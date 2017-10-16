#lang sicp

(define (last-pair x)
  (if (null? (cdr x))
      x
      (last-pair (cdr x))))

(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x)

; make-cycle 通过把自身的 cdr 指针指向自己，这样构成一个自身循环的无穷序列
; 所以 (last-pair z) 会进入一个无限循环
; 盒子图参考 http://sicp.readthedocs.io/en/latest/chp3/13.html
(define z (make-cycle (list 'a 'b 'c)))
(last-pair z)
