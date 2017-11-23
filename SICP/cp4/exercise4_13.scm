#lang sicp

(define (enclosing-environment env)
  (cdr env))
(define (first-frame env)
  (car env))
(define the-empty-environment '())

(define (make-frame variables values)
  (cons variables values))
(define (frame-variables frame) (car frame))
(define (frame-values frame) (cdr frame))

; 定义一个解决绑定 frame 中指定变量的方法
(define (unbound-frame-var! var frame)
  (define (scan vars vals)
    (cond ((null? vars)
            (error "Unbound a nondefined variable" var))
          ((eq? (car vars) var)
            (begin
              (set! vars (cdr vars))
              (set! vals (cdr vals))
              'done))
          (else (scan (cdr vars) (cdr vals)))))
  (scan (frame-variables frame) (frame-values frame)))

; 针对当前 frame 中的 var 解除绑定
(define (make-unbound! var env)
  (let ((frame (first-frame env)))
    (unbound-frame-var! var frame)))