#lang sicp

; 解答参考了 http://sicp.readthedocs.io/en/latest/chp1/46.html
(define (iterative-improve good-enough? improve)
  (lambda (first-guess)
    (define (try guess)
      (let ((next (improve guess)))
        (if (good-enough? guess next)
            next
            (try next))))
    (try first-guess)))

(define (fixed-point f first-guess)
  (define tolerance 0.00001)
  (define (good-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (improve guess) (f guess))
  ((iterative-improve good-enough? improve) first-guess))

(define (sqrt n)
  (define tolerance 0.00001)
  (define (good-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (improve guess)
    ((lambda (x y) (/ (+ x y) 2.0)) guess (/ n guess)))
  ((iterative-improve good-enough? improve) 1.0))

(fixed-point cos 1.0)
(sqrt 4)