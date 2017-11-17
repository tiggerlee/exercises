#lang sicp
; (let ((a (+ 1 2)) (b (+ 3 4)))
;   (* a b))

(define (let? exp)
  (tagged-list? exp 'let))

(define (let-body exp)
  (cddr exp))

(define (let-vars exp)
  (map car (cadr exp)))

(define (let-values exp)
  (map cadr (cadr exp)))

(define (eval-let exp)
  (cons (make-lambda (let-vars exp) (let-body exp))
        (let-values exp)))