#lang sicp

(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeats f n)
    (if (= n 1)
        f
        (compose f (repeats f (- n 1)))))

(define (square x) (* x x))

(define dx 0.00001)

(define (smooth f)
  (lambda (x)
    (/ (+ (f (- x dx))
          (f x)
          (f (+ x dx)))
        3)))

((smooth square) 5)

(define (smooth-n-times f n)
  ((repeats smooth n) f))

((smooth-n-times square 10) 5)