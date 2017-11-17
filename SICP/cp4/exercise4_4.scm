#lang sicp

(define (eval exp evn)
  (cond ((self-evaluating? exp)
         exp)
        ((variable? exp)
         (lookup-variable-value exp env))
        ((quoted? exp)
         (text-of-quotation exp))
        ((assignment? exp)
         (eval-assignment exp env))
        ((definition? exp)
         (eval-definition exp env))
        ((if? exp)
         (eval-if exp env))
        ; add for exercise 4.4
        ((and? exp) (eval-and (operands exp) env))
        ((or? exp) (eval-or (operands exp) env))
        ; add for exercise 4.4
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
        ((application? exp)
         (apply (eval (operator exp) env)
                (list-of-values
                 (operands exp)
                 env)))
        (else
         (error "Unknown expression type: EVAL " exp))))

(define (apply procedure arguments)
  (cond ((primitive-procedure? procedure)
         (apply-primitive-procedure
          procedure
          arguments))
        ((compound-procedure? procedure)
         (eval-sequence
          (procedure-body procedure)
          (extend-environment
           (procedure-parameters
            procedure)
           arguments
           (procedure-environment
            procedure))))
        (else
         (error "Unknown procedure type: APPLY" procedure))))

(define (list-of-values exps env)
  (if (no-operands exps)
      '()
      (cons (eval (first-operand exps) env)
            (list-of-values (rest-operands exps) env))))
; a) 使用新定义的求值过程
(define (and? exp)
  (tagged-list? exp 'and))
(define (eval-and ops env)
  (cond ((no-operands ops) ; 没有可求值表达式，返回 true
          true)
        ((last-operand? ops) ; 如果是最后一个表达式，返回这个表达式的值
          (true? (eval (first-operand ops) env)))
        ((not (true? (eval (first-operand ops) env))) ; 有表达式结果为 false，返回 false，结束求值过程
          false)
        (else ; 其他情况，继续求值剩余表达式
          (eval-and (rest-operands ops) env))))
(define (or? exp)
  (tagged-list? exp 'or))
(define (eval-or ops env)
  (cond ((no-operands ops) ; 没有可求值表达式，返回 false
          false)
        ((last-operand? ops) ; 如果是最后一个表达式，返回这个表达式的值
          (true? (eval (first-operand ops) env))
        ((true? (eval (first-operand ops) env)) ; 有表达式结果为 true，返回 true，结束求值过程
          true)
        (else  ; 其他情况，求值剩余表达式
          (eval-or (rest-operands ops) env)))))

; b) 使用派生表达式实现
(define (eval-and-use-if ops env)
  (and->if ops))

; and 可以用 if 表达为
; (if exp1
;     (if exp2
;        (if exp3
;             ...
;             false)
;         false)
;     false)
(define (and->if ops)
  (if (no-operands ops)
      true
      (make-if
        (first-operand ops)
        (and->if (rest-operands ops))
        false)))

(define (eval-or-use-if ops env)
  (or->if ops))

; or 可以用 if 表达为
; (if exp1
;     true
;     (if exp2
;         true
;         (if exp3
;             true
;             ...
(define (or->if ops)
  (if (no-operands ops)
      false
      (make-if
        (first-operand ops)
        true
        (or->if (rest-operands ops)))))

(define (eval-if exp env)
  (if (true? (eval (if-predicate exp) env))
      (eval (if-consequent exp) env)
      (eval (if-alternative exp) env)))

(define (eval-sequence exps env)
  (cond ((last-exp? exps) (eval (first-exp exps) env))
        (else (eval (first-exp exps) env)
              (eval-sequence (rest-exps exps) env))))

(define (eval-assignment exp env)
  (set-variable-value! (assignment-variable exp)
                       (eval (assignment-value exp) env)
                       env)
  'ok)

(define (eval-definition exp env)
  (define-variable! (definition-variable exp)
                    (eval (definition-value exp) env)
                    env)
  'ok)

(define (self-evaluating? exp)
  (cond ((number? exp) true)
        ((string? exp) true)
        (else false)))

(define (variable? exp) (symbol? exp))

(define (quoted? exp)
  (tagged-list? exp 'quote))

(define (text-of-quotation exp) (cadr exp))

(define (tagged-list? exp tag)
  (if (pair? exp)
      (eq? (car exp) tag)
      false))
(define (assignment? exp)
  (tagged-list? exp 'set!))
(define (assignment-variable exp) (cadr exp))
(define (assignment-value exp) (caddr exp))
(define (definition? exp)
  (tagged-list? exp 'define))
(define (definition-variable exp)
  (if (symbol? (cadr exp))
      (cadr exp)
      (caddr exp)))
(define (definition-value exp)
  (if (symbol? (cadr exp))
      (caddr exp)
      (make-lambda (cdadr exp)
                   (cddr exp))))
(define (lambda? exp) (tagged-list? exp 'lambda))
(define (lambda-parameters exp) (cadr exp))
(define (lambda-body) (cddr exp))
(define (make-lambda parameters body)
  (cons 'lambda (cons parameters body)))
(define (if? exp) (tagged-list? exp 'if))
(define (if-predicate exp) (cadr exp))
(define (if-consequent exp) (caddr exp))
(define (if-alternative exp)
  (if (not (null? (cdddr exp)))
      (cadddr exp)
      'false))
(define (make-if predicate consequent alternative)
  (list 'if predicate consequent alternative))
(define (begin? exp) (tagged-list? exp 'begin))
(define (begin-actions exp) (cdr exp))
(define (last-exp? seq) (null? (cdr seq)))
(define (first-exp seq) (car seq))
(define (rest-exps seq) (cdr seq))
(define (sequence->exp seq)
  (cond ((null? seq) seq)
        ((last-exp? seq) (first-exp seq))
        (else (make-begin seq))))
(define (make-begin seq) (cons 'begin seq))
(define (application? exp) (pair? exp))
(define (operator exp) (car exp))
(define (operands exp) (cdr exp))
(define (no-operands ops) (null? ops))
(define (first-operand ops) (car ops))
(define (rest-operands ops) (cdr ops))
(define (last-operand? ops) (null? (cdr ops)))
(define (cond? exp) (tagged-list? exp 'cond))
(define (cond-clauses exp) (cdr exp))
(define (cond-else-clause? clause)
  (eq? (cond-predicate clause) 'else))
(define (cond-predicate clause) (car clause))
(define (cond-actions clause) (cdr clause))
(define (cond->if exp)
  (expand-clauses (cond-clauses exp)))
(define (expand-clauses clauses)
  (if (null? clauses)
      'false
      (let ((first (car clauses))
            (rest (cdr clauses)))
        (if (cond-else-clause? first)
            (if (null? rest)
                (sequence->exp (cond-actions first))
                (error "ELSE clause isn't last -- COND->IF"
                       clauses))
            (make-if (cond-predicate first)
                     (sequence->exp (cond-actions first))
                     (expand-clauses rest))))))