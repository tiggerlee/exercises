#lang sicp

(define (make-point x y)
  (cons x y))

(define (x-point p)
  (car p))

(define (y-point p)
  (cdr p))

(define (make-segment start-point end-point)
  (cons start-point end-point))

(define (start-segment seg) 
  (car seg))

(define (end-segment seg) 
  (cdr seg))

(define (average x y)
  (/ (+ x y) 2.0))

(define (midpoint-segment segment)
  (make-point (average (x-point (start-segment segment))
                       (x-point (end-segment segment)))
              (average (y-point (start-segment segment))
                       (y-point (end-segment segment)))))

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))

(define segment (make-segment (make-point 1 3) (make-point 4 3)))

(print-point (midpoint-segment segment)) ; (2.5,3.0)