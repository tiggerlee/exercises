#lang sicp

(define zero (lambda (f) (lambda (x) x)))

(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

(add-1 zero)
; 代入 zero
; (lambda (f) (lambda (x) (f ((zero f) x))))
; (lambda (f) (lambda (x) (f (((lambda (f) (lambda (x) x)) f) x))))
; (lambda (f) (lambda (x) (f ((lambda (x) x) x))))
; (lambda (f) (lambda (x) (f x)))

(define one (lambda (f) (lambda (x) (f x))))

(add-1 one)
; (lambda (f) (lambda (x) (f ((one f) x))))
; (lambda (f) (lambda (x) (f (((lambda (f) (lambda (x) (f x))) f) x))))
; (lambda (f) (lambda (x) (f (((lambda (x) (f x)) x)))))
; (lambda (f) (lambda (x) (f (f x))))
(define two (lambda (f) (lambda (x) (f (f x)))))

(define (add a b) 
  (lambda (f) 
    (lambda (x) 
      ((a f) ((b f) x))))) 

; (add two one)
; ((a f) ((b f) x))
; (((lambda (f) (lambda (x) (f (f x)))) f) (((lambda (f) (lambda (x) (f x))) f) x))
; (((lambda (f) (lambda (x) (f (f x)))) f) (((lambda (x) (f x))) x))
; (((lambda (f) (lambda (x) (f (f x)))) f) (f x))
; (((lambda (x) (f (f x))) (f x))
; (f (f (f x)