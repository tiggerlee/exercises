#lang sicp

(define (cont-frac n d k)
  (define (compute index)
    (if (> index k)
        1
        (/ (n index) (+ (d index) (compute (inc index))))))
  (compute 1))

(define (square x) (* x x))


; 解答参考了 http://sicp.readthedocs.io/en/latest/chp1/39.html    
(define (tan-cf x k)
  (define (n i)
    (if (= i 1)
        x
        (- (square x))))
  (define (d i)
    (- (* 2 i) 1))
  (cont-frac n d k))

(exact->inexact (tan-cf 10 100))
(exact->inexact (tan-cf 25 100))
(exact->inexact (tan-cf 45 100))