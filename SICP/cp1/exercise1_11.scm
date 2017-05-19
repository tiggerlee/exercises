#lang sicp

; 递归版本
(define (f n)
  (cond ((< n 3) n)
        (else (+ (f (- n 1))
                 (* 2 (f (- n 2)))
                 (* 3 (f (- n 3)))))))

; 迭代版本 我参考了 http://sicp.readthedocs.io/en/latest/chp1/11.html 这个答案
; (f-iter 4)
; (fi 0 1 2 0)
; (fi 1 2 (+ 2 (* 2 1)) 1)
; (fi 1 2 4 1)
; (fi 2 4 (+ 4 (* 2 2) (* 3 1)) 2)
; (fi 2 4 11 2)
; (fi 4 11 (+ 11 (* 2 4) (* 3 2)) 3)
; (fi 4 11 25 3)
; (fi 11 25 (+ 25 (* 2 11) (* 3 4)) 4)
; (fi 11 25 59 4)
; i equals n, so result is 11
(define (f-iter n)
  (define (fi f0 f1 f2 i)
    (cond ((= i n) f0)
    (else (fi 
              f1
              f2
              (+ f2
                 (* 2 f1)
                 (* 3 f0))
              (+ i 1)))))
  (fi 0 1 2 0))

(define x 4)
(f-iter x)
(f x)

