#lang sicp

(define (count-pairs x)
  (if (not (pair? x))
      0
      (+ (count-pairs (car x))
         (count-pairs (cdr x))
         1)))

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
(count-pairs four)

(define seven (cons z z))
seven
(count-pairs seven)