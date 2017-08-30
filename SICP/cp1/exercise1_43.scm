#lang sicp

(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeats f n)
    (if (= n 1)
        f
        (compose f (repeats f (- n 1)))))

(define (square x) (* x x))

((repeats square 2) 5) ; 625