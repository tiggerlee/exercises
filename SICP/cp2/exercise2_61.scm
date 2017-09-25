#lang sicp

(define (element-of-set? x set)
  (cond ((null? set) #f)
        ((= x (car set)) #t)
        ((< x (car set)) #f)
        (else (element-of-set? x (cdr set)))))

(define (intersection-set set1 set2)
  (if (or (null? set1) (null? set2))
      '()
      (let ((x1 (car set1)) (x2 (car set2)))
        (cond ((= x1 x2)
               (cons x1
                     (intersection-set (cdr set1)
                                       (cdr set2))))
              ((< x1 x2)
               (intersection-set (cdr set1) set2))
              ((< x2 x1)
               (intersection-set set1 (cdr set2)))))))

; 除非我们要插入的元素比当前列表中所有元素都大，这样需要的步数和未排序一样
; 否则我们都能期望比较在靠近开始的位置停止
; 这样平均步数大概就是 n/2
(define (adjoin-set x set)
  (cond ((null? set) (cons x set))
        ((= x (car set)) set)
        ((< x (car set)) (cons x set))
        (else (cons (car set) (adjoin-set x (cdr set))))))

(define set (list 1 3 4 5 6))
(display (adjoin-set 2 set))
(newline)
(display (adjoin-set 7 set))
(newline)
(display (adjoin-set 0 set))
(newline)
(display (adjoin-set 2 '()))
(newline)
(display (adjoin-set 2 '(1 2)))