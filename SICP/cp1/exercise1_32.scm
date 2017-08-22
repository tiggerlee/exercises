#lang sicp

; 迭代版本
(define (accumulate-iter combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
      result
      (iter (next a)
        (combiner result (term a)))))
  (iter a null-value))

; 递归版本
(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a)
        (accumulate combiner null-value term (next a) next b))))

(define (sum term a next b)
  (accumulate-iter + 0 term a next b))

(define (cube x)
  (* x x x))

(define (identity x) x)

(sum identity 1 inc 10)  ; 55
(sum cube 1 inc 5)       ; 225

(define (product term a next b)
  (accumulate-iter * 1 term a next b))

(product identity 1 inc 10)  ; 3628800
(product cube 1 inc 10)      ; 47784725839872000000