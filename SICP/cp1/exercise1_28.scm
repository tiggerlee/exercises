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

(prime? 561)   ; #f 
(prime? 1105)  ; #f
(prime? 1729)  ; #f
(prime? 2465)  ; #f
(prime? 2821)  ; #f
(prime? 6601)  ; #f
(prime? 13)    ; #t
(prime? 15)    ; #f