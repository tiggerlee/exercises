#lang sicp 

(define square (lambda (x) (* x x)))

(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons (square (car things))
                    answer))))
  (iter items nil))


(define items (list 1 2 3 4))
(square-list items) ; (16 9 4 1)
; 使用替换法分析
; (iter (1 2 3 4) nil)
; (iter (2 3 4) (cons 1 nil))
; (iter (3 4) (cons 4 (cons 1 nil)))
; (iter (4) (cons 9 (cons 4 (cons 1 nil))))
; (iter () (cons 16 (cons 9 (cons 4 (cons 1 nil)))))
; (cons 16 (cons 9 (cons 4 (cons 1 nil))))

(define (square-list-fix items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons answer
                    (square (car things))))))
  (iter items nil))

(square-list-fix items) ; ((((nil 1) 4) 9) 16)
; 使用替代法分析
; (iter (1 2 3 4) nil)
; (iter (2 3 4) (cons nil 1))
; (iter (3 4) (cons (cons nil 1) 4))
; (iter (4) (cons (cons (cons nil 1) 4) 9))
; (iter () (cons (cons (cons (cons nil 1) 4) 9) 16))
; (cons (cons (cons (cons nil 1) 4) 9) 16)