#lang sicp

(define (square x) (* x x))

(define (f g) (g 2))

(f square)
;((lambda (x) (* x x)) 2)
(f (lambda (z) (* z (+ z 1))))
; 解答参考了 http://sicp.readthedocs.io/en/latest/chp1/34.html
; 在racket中显示由于2不是一个procedure而出错
; 为什么出现错误，可以展开这个表达式
(f f)
; 首先使用替代法展开(f f)
;((lambda (x) (x 2)) 2)
; 将2作为参数传入，lambda会将2作为一个操作符应用于参数之上求值，导致上述错误
;(2 2)