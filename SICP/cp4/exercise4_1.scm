#lang sicp

; 从左到右求求值
(define (list-of-values exps env)
  (if (not-operands? exps)
      '()
      (let ((first (eval (first-operand exps) env)))
        (cons first
              (list-of-values (rest-operands exps) env)))))

; 从右到左求值
(define (list-of-values exps env)
  (if (not-operands? exps)
      '()
      (let ((rest (list-of-values (rest-operands exps) env)))
        (cons (eval (first-operand exps) env)
              rest))))