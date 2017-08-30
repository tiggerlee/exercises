#lang sicp

(define (double f) 
  (lambda (x) (f (f x))))

((double inc) 1)                   ; 3
((double (lambda (x) (* x x))) 2)  ; 16
(((double (double double)) inc) 5) ; 21