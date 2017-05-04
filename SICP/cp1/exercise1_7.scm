#lang sicp

(define (sqrt-iter x guess)
  (if (good-enough? guess (improve x guess))
      (improve x guess)
      (sqrt-iter x (improve x guess))))

(define (improve x guess)
  (average (/ x guess)
           guess))

(define (average x y)
  (/ (+ x y) 2))

(define (square x)
  (* x x))

(define (good-enough? old-guess guess)
  (< (/ (abs (- old-guess
             guess))
        old-guess)
     0.0001))

(define (sqrt x)
  (sqrt-iter x (/ x 2.0)))



(square 0.00000023123)

(sqrt (square 0.00000023123))

(- 0.00000023123 (sqrt (square 0.00000023123)))



(square 123123123123123123111323)

(sqrt (square 123123123123123123111323))

(- 123123123123123123111323 (sqrt (square 123123123123123123111323)))
