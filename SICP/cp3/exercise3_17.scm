#lang sicp

(define (count-pairs x)
  (length (inner x '())))

(define (not-found x list)
  (not (list? (memq x list))))

(define (inner x result)
  (if (and (pair? x)
           (not-found x result))
      (inner (car x)
             (inner (cdr x) (cons x result)))
      result))

(define x (list 'a 'b))
(define infinite-loop (begin (set-cdr! (cdr x) x) x))
; (count-pairs infinite-loop) ; infinite loop

(define three (cons (cons 1 nil) (cons 2 nil)))
three
(count-pairs three) ; 3

(define y '(foo))
(define z (cons y y))
(define four (list z))
four
(count-pairs four) ; 3

(define seven (cons z z))
seven
(count-pairs seven) ; 3