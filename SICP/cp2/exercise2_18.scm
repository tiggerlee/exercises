#lang sicp 

(define (reverse l)
  (define (iter l r)
    (if (null? l)
        r
        (iter (cdr l)
              (cons (car l) r))))
  (iter l '()))

(reverse (list 1 4 9 16 25))
; 替换过程
; (iter (4 9 16 25) (cons 1 '()))
; (iter (9 16 25) (cons 4 (cons 1 '())))
; (iter (16 25) (cons 9 (cons 4 (cons 1 '()))))
; (iter (25) (cons 16 (cons 9 (cons 4 (cons 1 '())))))
; (iter nil (cons 25 (cons 16 (cons 9 (cons 4 (cons 1 '()))))))
; (cons 25 (cons 16 (cons 9 (cons 4 (cons 1 '())))))