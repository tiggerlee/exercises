#lang sicp

(define (square x)
  (* x x))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
             ((divides? test-divisor n) test-divisor)
             (else (find-divisor n (+ test-divisor 1)))))

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

; 解答参考 http://community.schemewiki.org/?sicp-ex-1.22
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

; n每增加10倍，时间增加大约为√10
(search-for-primes 10000000000000 3)
; 10000000000037 *** 46020
; 10000000000051 *** 49034
; 10000000000099 *** 47033

(search-for-primes 100000000000000 3)
; 100000000000031 *** 150106
; 100000000000067 *** 151108
; 100000000000097 *** 150106

(search-for-primes 1000000000000000 3)
; 1000000000000037 *** 475337
; 1000000000000091 *** 477353
; 1000000000000159 *** 475337

(search-for-primes 10000000000000000 3)
; 10000000000000061 *** 1525085
; 10000000000000069 *** 1530101
; 10000000000000079 *** 1530074