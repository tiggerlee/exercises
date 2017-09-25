#lang sicp

(define (element-of-set? x set)
  (cond ((null? set) #f)
        ((equal? x (car set)) #t)
        (else (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
  (if (element-of-set? x set)
      set
      (cons x set)))

(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) '())
        ((element-of-set? (car set1) set2)
         (cons (car set1)
               (intersection-set (cdr set1) set2)))
        (else (intersection-set (cdr set1) set2))))

(define (union-set set1 set2)
  (if (null? set1)
      set2
      (union-set (cdr set1)
                 (adjoin-set (car set1) set2))))

(define set1 (list 1 2 3 4))
(define set2 (list 1 3 5 7))
(display (adjoin-set 5 set1)) ; (5 1 2 3 4)
(newline)
(display (adjoin-set 5 set2)) ; (1 3 5 7)
(newline)
(display (intersection-set set1 set2)) ; (1 3)
(newline)
(display (union-set set1 set2)) ; (4 2 1 3 5 7)
