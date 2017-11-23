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

(define (add-binding-to-frame! var val frame)
  (set-car! frame (cons var (car frame)))
  (set-cdr! frame (cons val (cdr frame))))

(define (extend-environment vars vals base-env)
  (if (= (length vars) (length vals))
      (cons (make-frame vars vals) base-env)
      (if (< (length vars) (length vals))
          (error "Too many arguments supplied" vars vals)
          (error "Too few arguments supplied" vars vals))))

; 定义一个方法，查找 frame 中变量的值，找不到返回false
(define (lookup-variable-value-in-frame var frame)
  (let ((vars (frame-variables frame))
        (vals (frame-values frame)))
    (define (scan vars vals)
      (cond ((null? vars) false)
            ((eq? var (car vars)) (car vals))
            (else (scan (cdr vars) (cdr vals)))))
    (scan vars vals)))

; 定义一个方法，给 frame 中的一个变量 var 设置值 val
; frame 中存 var 则设置 var 的值为 val 并返回 true
; 不存在 var 返回 false
(define (set-binding-to-frame! var val frame)
  (define (scan vars vals)
    (cond ((null? vars) false)
          ((eq? vars (car vars))
            (begin
                (set-car! vals val)
                true))
          (else (scan (cdr vars) (cdr vals)))))
  (scan (frame-variables frame) (frame-values frame)))

(define (lookup-variable-value var env)
  (define (env-loop env)
    (if (eq? env the-empty-environment)
        (error "Unbound variable" var)
        (let ((frame (first-frame env)))
          (let ((found-value (lookup-variable-value-in-frame var frame)))
            (if (not (lookup-variable-value-in-frame var frame))
                (env-loop (enclosing-environment env))
                found-value)))))
  (env-loop env))

(define (set-variable-value! var val env)
  (define (env-loop env)
    (if (eq? env the-empty-environment)
        (error "Unbound variable -- SET!" var)
        (let ((frame (first-frame env)))
          (if (set-binding-to-frame! var val frame)
              'done
              (env-loop (enclosing-environment env))))))
  (env-loop env))

(define (define-variable! var val env)
  (let ((frame (first-frame env)))
    (if (set-binding-to-frame! var val frame)
        'done
        (add-binding-to-frame! var val frame))))