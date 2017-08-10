#lang sicp

(define (double n)
  (+ n n))

(define (halve n)
  (/ n 2))

; recursive
(define (r* a b)
  (cond ((= b 0) 0)
        ((even? b) (r* (double a) (halve b)))
        (else (+ a (r* a (- b 1))))))

; iterative
(define (* a b)
  (define (iter r a b)
    (cond ((= b 0) r)
          ((even? b) (iter r (double a) (halve b)))
          (else (iter (+ r a) a (- b 1)))))
  (iter 0 a b))

(* 3 4)
(* 4 1)
(* 4 0)
(* 3 5)
(* 5 3)
(* 11 100)
(* 100 11)
(r* 3 4)
(r* 4 1)
(r* 4 0)
(r* 3 5)
(r* 5 3)
(r* 11 100)
(r* 100 11)