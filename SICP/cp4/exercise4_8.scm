#lang sicp

; 普通 let
; (let ((a (+ 1 2)) (b (+ 3 4)))
;   (* a b))

; 命名 let
; (define (fib n)
;   (let fib-iter ((a 1)
;                  (b 0)
;                  (count n))
;     (if (= count 0)
;         b
;         (fib-iter (+ a b) a (- count 1)))))
; 上述的命名 let 可以转换为下面使用 lambda 的写法
(define (fib n)
  (define fib-iter
    (lambda (a b count)
      (if (= count 0)
          b
          (fib-iter (+ a b) a (- count 1)))))
  (fib-iter 1 0 n))

(define (let? exp)
  (tagged-list? exp 'let))

(define (let-body exp)
  (cddr exp))

(define (let-vars exp)
  (map car (cadr exp)))

(define (let-values exp)
  (map cadr (cadr exp)))

(define (eval-let exp)
  (if (name-let exp)
      (sequence->exp
        (list
          (list
            'define
            (name-let-lambda-name exp)
            (make-lambda (name-let-vars exp) (name-let-body exp))
            )
          (cons (name-let-lambda-name exp) (name-let-values exp))))
      (cons (make-lambda (let-vars exp) (let-body exp))
            (let-values exp))))

; 通过判断表达式中第二个元素是否为列表判定是否命名 let 
(define (name-let exp)
  (not (pair? (cadr exp))))

(define (name-let-lambda-name exp)
  (cadr exp))

(define (name-let-vars exp)
  (map (car (caddr exp))))

(define (name-let-values exp)
  (map (cadr (caddr exp))))

(define (name-let-body exp)
  (map (cadr (caddr exp))))

(define (sequence->exp seq)
  (cond ((null? seq) seq)
        ((last-exp? seq) (first-exp seq))
        (else (make-begin seq))))