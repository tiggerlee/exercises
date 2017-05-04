#lang sicp

(define (square x)
  (* x x))

(define (cube x)
  (* x x x))

(define (cube-root-iter x guess)
  (if (good-enough? (improve guess x) guess)
      (improve guess x)
      (cube-root-iter x (improve guess x))))

(define (good-enough? guess old-guess)
  (< (/ (abs (- guess old-guess))
        old-guess)
     0.0001))

(define (improve guess x)
  (/ (+ (/ x (square guess))
        (* 2 guess))
     3))

(define (cube-root x)
  (cube-root-iter x (/ x 3.0)))

(cube-root (cube 123))
(cube-root (cube 0.0000000123321123312))
(cube-root (cube 123123123123123111232213))