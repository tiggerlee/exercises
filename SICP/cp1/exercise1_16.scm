#lang sicp

(define (square n)
  (* n n))

(define (expt b n)
  (define (eiter product counter)
    (cond ((= counter 0) 1)
          ((even? counter) (eiter (square product)
                                  (/ counter 2)))
          (else (* product (eiter product
                                  (- counter 1))))))
  (eiter b n))
    

(expt 3 3)
(expt 3 0)
(expt 3 1)
(expt 3 100)
