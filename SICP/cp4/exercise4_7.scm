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
; 判断表达式是不是 let* 
; 如果是的话，调用 let*->lets 将表达式转换为嵌套的 let 表达式
(define (let*? exp)
  (tagged-list? exp 'let*))

; (let* ((x 3)
;        (y (+ x 2))
;        (z (+ x y 5)))
;   (* x z))
; 上述的 let* 表达式可以转换为下面嵌套的 let 表达式
; (let ((x 3))
;   (let ((y (+ x 2)))
;     (let ((z (+ x y 5)))
;       (* x z))))
; 将 let* 表达式转换为嵌套的 let 表达式
(define (let*->lets exp)
  (define (make-nested-lets init-values body)
    (if (null? init-values)
        body
        (make-let 
          (list (car init-values))
          (make-nested-lets (cdr init-values) body))))
  (make-nested-lets (cadr exp) (caddr exp)))

; 辅助方法，帮助构造 let 表达式
(define (make-let init body)
  (list 'let init body))