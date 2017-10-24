#lang sicp

(define (lookup key table)
  (let ((record (assoc key (cdr table))))
    (if record
        (cdr record)
        #f)))
(define (insert! key value table)
  (let ((record (assoc key (cdr table))))
    (if record
        (set-cdr! record value)
        (set-cdr! table (cons (cons key value) (cdr table))))))
          
(define (make-table)
  (display "maketable")
  (newline)
  (list '*table*))

(define (fib n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (fib (- n 1))
                 (fib (- n 2))))))

(define (memoize f)
  (let ((table (make-table)))
    (lambda (x)
      (let ((previously-computed-result (lookup x table)))
        (or previously-computed-result
            (let ((result (f x)))
              (insert! x result table)
              (display table)
              (newline)
              result))))))
; memo-fib 对于每个数值，只计算一次，然后将计算的结果存储在表里
; 没有重复计算，所以复杂度正比于 n
(define memo-fib
  (memoize (lambda (n)
             (cond ((= n 0) 0)
                   ((= n 1) 1)
                   (else (+ (memo-fib (- n 1))
                            (memo-fib (- n 2))))))))

; 使用 (memoize fib) 定义的话，每次的结果还是要重复计算得出，只是将最后一次的计算结果存储
; 所以结果正确，但是复杂度还是指数级的
(define memo-fib-fib (memoize fib))

(memo-fib 3)