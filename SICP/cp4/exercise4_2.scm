#lang sicp

(define (eval exp evn)
  (cond ((self-evaluating? exp)
         exp)
        ((variable? exp)
         (lookup-variable-value exp env))
        ((quoted? exp)
         (text-of-quotation exp))
        ((application? exp)
         (apply (eval (operator exp) env)
                (list-of-values
                 (operands exp)
                 env)))
        ((assignment? exp)
         (eval-assignment exp env))
        ((definition? exp)
         (eval-definition exp env))
        ((if? exp)
         (eval-if exp env))
        ((lambda? exp)
         (make-procedure
          (lambda-parameters exp)
          (lambda-body exp)
          env))
        ((begin? exp)
         (eval-sequence
          (begin-actions exp)
          env))
        ((cond? exp)
         (eval (cond->if exp) env))
        (else
         (error "Unknown expression type: EVAL " exp))))

; a)
; 将 application 放在 assignment之前，会导致 eval 会对一些特殊形式的语句执行调用
; 例如 (define x 3)，eval 会将 define 作为一个过程，x 和 3 作为参数进行调用

; b)
; 修改 application?, operator 和 operands 三个方法的实现

(define (application? exp)
  (if (eq? (car exp) 'call)
      true
      false))
(define (operator exp) (cadr exp))
(define (operands exp) (cddr exp))