#lang sicp

(define (gcd x y)
  (if (= y 0)
      (abs x)
      (gcd y (remainder x y))))

(define (make-rat n d)
  (let ((g ((if (< d 0) - +) (gcd n d))))
    (cons (/ n g)
          (/ d g))))

(define (numer x)
  (car x))
        
(define (denom x)
  (cdr x))
        
(define (print-rat x)
  (newline)
  (display (numer x))
  (display "/")
  (display (denom x)))

(print-rat (make-rat 3 4))
(print-rat (make-rat -3 4))
(print-rat (make-rat -3 -4))
(print-rat (make-rat 3 -4))