#lang sicp

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
        (cond ((cond-else-clause? first)
                (if (null? rest)
                  (sequence->exp (cond-actions first))
                  (error "ELSE clause isn't last -- COND->IF"
                        clauses)))
              ((extended-cond-syntax? first) ; 是否特殊表达式
                (list (extended-cond-recipient first) ; 取出来 recipient，应用在 test 上
                      (extended-cond-test first))
                (expand-clauses rest)) ; 继续处理剩余的语句
              (else ; 正常的 cond 表达式
                (make-if (cond-predicate first)
                        (sequence->exp (cond-actions first))
                        (expand-clauses rest)))))))

; 判断是不是特殊表达式
(define (extended-cond-syntax? exp)
  (and (list? exp)
       (> (length exp) 2)
       (equal? (cadr exp) '=>)))

(define (extended-cond-test exp)
  (car exp))

(define (extended-cond-recipient exp)
  (caddr exp))