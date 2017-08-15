#lang sicp
; http://community.schemewiki.org/?sicp-ex-1.24
(#%require (lib "27.ss" "srfi"))

(define (square n)
  (* n n))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
	((even? exp)
	 (remainder (square (expmod base (/ exp 2) m))
		    m))
	(else
	 (remainder (* base (expmod base (- exp 1) m))
		    m))))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random-integer (- n 1)))))

(define (prime? n)
  (define (fast-prime? n times)
    (cond ((= times 0) #t)
	  ((fermat-test n) (fast-prime? n (- times 1)))
	  (else #f)))
  (fast-prime? n 10))

(define (report-prime n elapsed-time)
  (newline)
  (display n)
  (display " *** ")
  (display elapsed-time))

(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime n (- (runtime) start-time))
      #f))

(define (time-prime-test n)
  (start-prime-test n (runtime)))

(define (search-for-primes n counter)
  (define (search n c)
    (if (> c 0)
      (if (time-prime-test n)
          (search (+ n 2) (- c 1))
          (search (+ n 2) c))
          "Computation complete"))
  (if (even? n)
      (search (+ n 1) counter)
      (search n counter)))

(search-for-primes 100000000000000005670000000000000000 3)
(search-for-primes 1000000000000000000432000000000000000000000000000000000000000000000000000000000000 3)