#lang sicp

(define (cont-frac n d k)
  (define (compute index)
    (if (> index k)
        1
        (/ (n index) (+ (d index) (compute (inc index))))))
  (compute 1))
    
; 1, 2, 1, 1, 4, 1, 1, 6, 1, 1, 8
; 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11
; 解答参考了 http://sicp.readthedocs.io/en/latest/chp1/38.html
(define (d i)
  (if (= (remainder (+ i 1) 3) 0)
      (* 2 (/ (+ i 1) 3))
      1))

(define (dfc k)
  (cont-frac (lambda (i) 1) d k))


(define (e k) (+ 2.0 (dfc k)))

(e 1)    ; 2.5
(e 10)   ; 2.718282368249837
(e 100)  ; 2.718281828459045