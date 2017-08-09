#lang sicp

(define (double n)
  (+ n n))

(define (hvalue n)
  (/ n 2))

(define (* a b)
  (define (*iter sum counter)
    (cond ((= counter 0) 0)
          ((even? counter) (*iter (double sum)
                                  (hvalue counter)))
          (else (+ sum (*iter sum (- counter 1))))))
  (*iter a b))

(* 1 3)
(* 7 8)
(* 0 7)
(* 7 0)
(* 7 1)
(* 7 3)
(* 7 2)
(* 7 5)
