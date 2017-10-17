#lang sicp

(define (last-pair x)
  (if (null? (cdr x))
      x
      (last-pair (cdr x))))

(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x)

(define x (list 'a 'b 'a))
(define z (make-cycle (list 'a 'b 'c)))

(define (is-a-cycle x)
  (define visited nil)
  (define (iter x)
    (set! visited (cons x visited))
    (cond ((null? (cdr x)) #f)
          ((memq (cdr x) visited) #t)
          (else (iter (cdr x)))))
  (iter x))

(is-a-cycle z)
(is-a-cycle x)