#lang sicp

(define square
  (lambda (x) (* x x)))

(square 2)

(define (compose f g)
  (lambda (x) (f (g x))))

((compose square inc) 6) ; 49
