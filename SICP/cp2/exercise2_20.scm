#lang sicp

(define (same-parity x . y)
  (define (same? a b)
    (or (and (even? a)
             (even? b))
        (and (odd? a)
             (odd? b))))
  (define (filter l)
    (cond ((null? l) nil)
          ((same? x (car l)) (cons (car l) (filter (cdr l))))
          (else (filter (cdr l)))))
  (cons x (filter y)))

(same-parity 1 2 3 4 5 6 7 8 9)  ; (1 3 5 7 9)
(same-parity 2 3 4 5 6 7 8 9 10) ; (2 4 6 8 10)