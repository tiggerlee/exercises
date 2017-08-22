#lang sicp
(#%require (lib "27.ss" "srfi"))

(define (square n)
	(* n n))

(define (miller-rabin-expmod base exp m)
  (cond ((= exp 0) 1)
				((nontrivial-square-root? base m) 0)
				((even? exp)
	 				(remainder (square (miller-rabin-expmod base (/ exp 2) m))
		    						 m))
				(else
	 				(remainder (* base (miller-rabin-expmod base (- exp 1) m))
		   							 m))))

(define (nontrivial-square-root? base m)
  (and (not (= base 1))
       (not (= base (- m 1)))
       (= 1 (remainder (square base) m))))

(define (prime? n)
  (define (iter times)
    (cond ((= times 0) #t)
	  			((= (miller-rabin-expmod (+ 1 (random-integer (- n 1))) (- n 1) n) 1) (iter (- times 1)))
	  			(else #f)))
  (iter (ceiling (/ n 2))))

(prime? 13)   ; #t
(prime? 100)  ; #f

(define (filter-accumulate filter combiner null-value term a next b)
  (cond ((> a b) null-value)
        ((filter a) (combiner (term a)
                              (filter-accumulate filter combiner null-value term (next a) next b)))
        (else (filter-accumulate filter combiner null-value term (next a) next b))))

(define (identity x) x)

(define (sum-prime a b)
  (filter-accumulate prime? + 0 identity a inc b))

; 计算素数之和
(sum-prime 2 10) ; 17

(define (product-prime n)
  ; 计算两个数的最大公约数是否为1
  (define (isgcd1 x)
    (define (gcd x y)
      (if (= y 0)
          x
          (gcd y (remainder x y))))
    (= (gcd x n) 1))
  (filter-accumulate isgcd1 * 1 identity 1 inc n))

(product-prime 10) ; 189