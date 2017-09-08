#lang sicp

(define (square-list items)
  (if (null? items)
      nil
      (cons ((lambda (x) (* x x)) (car items)) (square-list (cdr items)))))

(define (square-list-map items)
  (map (lambda (x) (* x x)) items))

(define items (list 1 2 3 4))
(square-list items)
(square-list-map items)
