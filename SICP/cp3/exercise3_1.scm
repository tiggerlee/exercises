#lang sicp

(define (make-accumulator initial)
  (define (accumulator value)
    (set! initial (+ initial value))
    initial)
  accumulator)

(define A (make-accumulator 5))
(A 10) ; 15
(A 10) ; 25
(define B (make-accumulator 5))
(B 5)  ; 10
(B 10) ; 20
