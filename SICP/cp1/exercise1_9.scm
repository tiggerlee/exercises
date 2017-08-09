#lang sicp

(define (r+ a b)
  (if (= a 0)
     b
     (inc (r+ (dec a) b))))
; r+是一个线性递归过程
; (r+ 4 5)
; (inc (r+ 3 5))
; (inc (inc (r+ 2 5)))
; (inc (inc (inc (r+ 1 5))))
; (inc (inc (inc (inc (r+ 0 5)))))
; (inc (inc (inc (inc 5))))
; (inc (inc (inc 6)))
; (inc (inc 7))
; (inc 8)
; 9

(define (i+ a b)
  (if (= a 0)
     b
     (i+ (dec a) (inc b))))
; i+是一个线性迭代过程
; (i+ 4 5)
; (i+ 3 6)
; (i+ 2 7)
; (i+ 1 8)
; (i+ 0 9)
; 9

(r+ 4 5)
(i+ 4 5)
