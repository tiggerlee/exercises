#lang sicp

; for put and get
(#%require (only racket/base error))
(#%require (only racket/base make-hash))
(#%require (only racket/base hash-set!))
(#%require (only racket/base hash-ref))

(define *op-table* (make-hash))

(define (put op type proc)
  (hash-set! *op-table* (list op type) proc))

(define (get op type)
  (hash-ref *op-table* (list op type) #f))
; for put and get

(define (variable? x) (symbol? x))

(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (=number? exp num)
  (and (number? exp) (= exp num)))

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp) (if (same-variable? exp var) 1 0))
        (else ((get 'deriv (operator exp)) (operands exp)
                                           var))))

(define (operator exp) (car exp))
(define (operands exp) (cdr exp))

; b
(define (install-sum-package)
  (define (addend s) (car s))
  (define (augend s) (cadr s))
  (define (make-sum a1 a2)
    (cond ((=number? a1 0) a2)
          ((=number? a2 0) a1)
          ((and (number? a1) (number? a2)) (+ a1 a2))
          (else (list '+ a1 a2))))
  (put 'deriv '+
       (lambda (exp var)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var))))
  (put 'deriv 'make-sum make-sum)
  'done)

(define (make-sum a1 a2)
  ((get 'deriv 'make-sum) a1 a2))

(define (install-product-package)
  (define (multiplier p) (car p))
  (define (multiplicand p) (cadr p))
  (define (make-product m1 m2)
    (cond ((or (=number? m1 0) (=number? m2 0)) 0)
          ((=number? m1 1) m2)
          ((=number? m2 1) m1)
          ((and (number? m1) (number? m2)) (* m1 m2))
          (else (list '* m1 m2))))
  (put 'deriv '*
       (lambda (exp var)
         (make-sum
          (make-product (multiplier exp)
                        (deriv (multiplicand exp) var))
          (make-product (deriv (multiplier exp) var)
                        (multiplicand exp)))))
  (put 'deriv 'make-product make-product)
  'done)

; c
(define (make-product m1 m2)
  ((get 'deriv 'make-product) m1 m2))

(define (install-exponent-package)
  (define (base s) (car s))
  (define (exponent s) (cadr s))
  (define (make-exponentiation base exponent)
    (cond ((= exponent 0) 1)
          ((= exponent 1) base)
          (else (list '** base exponent))))
  (put 'deriv '**
       (lambda (exp var)
         (let ((n (exponent exp))
               (u (base exp)))
           (make-product
            n
            (make-product
             (make-exponentiation
              u
              (- n 1))
             (deriv u var))))))
  'done)

; d
; 只需要修改 put 的位置就行，修改为 (put '+ 'deriv xxxx)

(install-sum-package)
(install-product-package)
(install-exponent-package)
(display (deriv '(+ x 3) 'x))
(newline)
(display (deriv '(* x y) 'x))
(newline)
(display (deriv '(* (* x y) (+ x 3)) 'x))
(newline)
(display (deriv '(** x 3) 'x))
