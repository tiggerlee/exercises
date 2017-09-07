#lang sicp

(define (make-interval a b) (cons a b))
(define (upper-bound z) (max (car z) (cdr z)))
(define (lower-bound z) (min (car z) (cdr z)))

(define test1 (make-interval 1 7))
(upper-bound test1)
(lower-bound test1)

(define test2 (make-interval 7 1))
(upper-bound test2)
(lower-bound test2)