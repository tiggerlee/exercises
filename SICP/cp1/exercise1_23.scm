#lang sicp

(define (square x)
  (* x x))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (next-divisor n)
  (if (= n 2)
      3
      (+ n 2)))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
             ((divides? test-divisor n) test-divisor)
             (else (find-divisor n (next-divisor test-divisor)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

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

; 使用next-divisor之后，速度大概提升了1.8, 1.9倍左右。
(search-for-primes 10000000000000 3)
; 10000000000037 *** 46020
; 10000000000051 *** 49034
; 10000000000099 *** 47033
; use next-divisor
; 10000000000037 *** 25031
; 10000000000051 *** 25004
; 10000000000099 *** 25032

(search-for-primes 100000000000000 3)
; 100000000000031 *** 150106
; 100000000000067 *** 151108
; 100000000000097 *** 150106

; use next-divisor
; 100000000000031 *** 76052
; 100000000000067 *** 77069
; 100000000000097 *** 76051

(search-for-primes 1000000000000000 3)
; 1000000000000037 *** 475337
; 1000000000000091 *** 477353
; 1000000000000159 *** 475337

; use next-divisor
; 1000000000000037 *** 242173
; 1000000000000091 *** 243173
; 1000000000000159 *** 242187

(search-for-primes 10000000000000000 3)
; 10000000000000061 *** 1525085
; 10000000000000069 *** 1530101
; 10000000000000079 *** 1530074

; use next-divisor
; 10000000000000061 *** 758554
; 10000000000000069 *** 760527
; 10000000000000079 *** 759553