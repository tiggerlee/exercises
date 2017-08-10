#lang sicp

(define (double n)
  (+ n n))

(define (halve n)
  (/ n 2))

; iterative
(define (* a b)
  (define (iter r a b)
    (cond ((= b 0) r)
          ((even? b) (iter r (double a) (halve b)))
          (else (iter (+ r a) a (- b 1)))))
  (iter 0 a b))

(* 1 3)
(* 7 8)
(* 0 7)
(* 7 0)
(* 7 1)
(* 7 3)
(* 7 2)
(* 7 5)
