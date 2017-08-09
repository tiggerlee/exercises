#lang sicp

(define (double n)
  (+ n n))

(define (hvalue n)
  (/ n 2))

(define (* a b)
  (cond ((= b 0) 0)
        ((even? b) (double (* a (hvalue b))))
        (else (+ a (* a (- b 1))))))

(* 1 3)
(* 7 8)
(* 0 7)
(* 7 0)
(* 7 1)
(* 7 3)
(* 7 2)
(* 7 5)
