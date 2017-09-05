#lang sicp

(define (cons x y)
  (lambda (m) (m x y)))

(define (car z)
  (z (lambda (p q) p)))

; 解答参考了 http://community.schemewiki.org/?sicp-ex-2.4
(car (cons 1 2))
; (car (lambda (m) (m 1 2)))                ; 展开 cons
; ((lambda (m) (m 1 2)) (lambda (p q) p))   ; 展开 car
; ((lambda (p q) p) 1 2)                    ; 替换 m
; 1                                         ; 结果

(define (cdr z)
  (z (lambda (p q) q)))

(cdr (cons 1 2))
; (cdr (lambda (m) (m 1 2)))
; ((lambda (m) (m 1 2)) (lambda (p q) q))
; ((lambda (p q) q) 1 2)
; 2

(define test (cons -1 7))
(car test) ; - 1
(cdr test) ; 7