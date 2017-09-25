#lang sicp

; 在调用 adjoin-set, union-set 比较多的应用中使用无序的表示方式
; 在调用 element-of-set?, intersection-set 比较多的应用中使用有序的表示方式效率好高

(define (element-of-set? x set)
  (cond ((null? set) #f)
        ((equal? x (car set)) #t)
        (else (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
  (cons x set))

(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) '())
        ((element-of-set? (car set1) set2)
         (cons (car set1)
               (intersection-set (cdr set1) set2)))
        (else (intersection-set (cdr set1) set2))))

(define (union-set set1 set2)
  (append set1 set2))

(define set1 (list 1 2 3 4))
(define set2 (list 1 3 5 7))
(display (adjoin-set 5 set1))
(newline)
(display (adjoin-set 5 set2))
(newline)
(display (intersection-set set1 set2))
(newline)
(display (union-set set1 set2))
