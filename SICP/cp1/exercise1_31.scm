#lang sicp

; 递归版本
(define (product-recu term a next b)
  (if (> a b)
      1
      (* (term a)
         (product-recu term (next a) next b))))

; 迭代版本
(define (product term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (* result (term a)))))
  (iter a 1))

(define (identity x) x)

(define (factorial n)
  (product identity 1 inc n))

(factorial 4)  ; 24
(factorial 7)  ; 5040
(factorial 10) ; 3628800


; 解答参考了 http://sicp.readthedocs.io/en/latest/chp1/31.html

(define (pi n)
  (define (numerator x)
    (cond ((even? x) (+ x 2))
          (else (+ x 1))))
  (define (denominator x)
    (cond ((even? x) (+ x 1))
          (else (+ x 2))))
  (* 4 (exact->inexact (/ (product numerator 1 inc n)
                          (product denominator 1 inc n)))))

(pi 100)     ; 3.1570301764551676
(pi 1000)    ; 3.1431607055322663
(pi 10000)   ; 3.1417497057380523
(pi 100000)  ; 3.1416083612781764