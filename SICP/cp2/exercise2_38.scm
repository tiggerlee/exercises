#lang sicp

(define (fold-right op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (fold-right op initial (cdr sequence)))))

(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))

(fold-right + 0 (list 1 2 3 4))
; fold-right 替换过程
; (+ 1 (fold-right + 0 (2 3 4)))
; (+ 1 (+ 2 (fold-right + 0 (3 4))))
; (+ 1 (+ 2 (+ 3 (fold-right + 0 (4)))))
; (+ 1 (+ 2 (+ 3 (+ 4 (fold-right + 0 ())))))
; (+ 1 (+ 2 (+ 3 (+ 4 0))))
; 10
(fold-left + 0 (list 1 2 3 4))
; (iter 0 (1 2 3 4))
; (iter (+ 0 1) (2 3 4))
; (iter (+ 1 2) (3 4))
; (iter (+ 3 3) (4))
; (iter (+ 6 4) ())
; (iter 10 ())
; 10

(fold-right / 1 (list 1 2 3)) ; (/ 1 (/ 2 (/ 3 1))) = 3/2
(fold-left  / 1 (list 1 2 3)) ; (/ (/ (/ 1 1 ) 2) 3) = 1/6
(fold-right list nil (list 1 2 3)) ; (list 1 (list 2 (list 3))) = (1 (2 (3 ())))
(fold-left  list nil (list 1 2 3)) ; (list (list (list '() 1) 2) 3) = (((() 1) 2) 3)

; 符合交换律和结合律的运算符两个过程计算结果一样
(fold-left + 0 (list 1 2 3 4))  ; 10
(fold-right + 0 (list 1 2 3 4)) ; 10
(fold-left * 1 (list 1 2 3 4))  ; 24
(fold-right * 1 (list 1 2 3 4)) ; 24