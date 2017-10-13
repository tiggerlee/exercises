#lang sicp

(define f
  (lambda (value)
    (set! f (lambda (second-value) 0))
    value))

(+ (f 0) (f 1))