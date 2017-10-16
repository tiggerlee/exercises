#lang sicp

(define (append! x y)
  (set-cdr! (last-pair x) y)
  x)

(define (last-pair x)
  (if (null? (cdr x))
      x
      (last-pair (cdr x))))

(define (append x y)
  (if (null? x)
      y
      (cons (car x) (append (cdr x) y))))

(define x (list 'a 'b))
(define y (list 'c 'd))
(define z (append x y))
; append 是通过构造新的序列来生成结果的，所有 x 的值没有改变
(cdr x) ; (b)
(define w (append! x y))
; append 是通过修改 x 的值生成结果的， 此时 x 的值为 (a b c d)
; 所以 (cdr x) 的结果为 (b c d)
; 盒子图参考 http://sicp.readthedocs.io/en/latest/chp3/12.html 
(cdr x) ; (b c d)