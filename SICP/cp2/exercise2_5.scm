#lang sicp

(define (expt base n)
  (cond ((= n 0) 1)
        ((even? n) (expt ((lambda (x) (* x x)) base) (/ n 2)))
        (else (* base (expt base (dec n))))))

(define (devide-x-times n x)
  (if (= (remainder n x) 0)
      (inc (devide-x-times (/ n x) x))
      0))

; 使用 2^x * 3^y 来表示 (cons x y)，那么car就是 (cons x y) 可以连续除以2没有余数的次数，cdr就是连续除以3没有余数的次数
(define (cons x y)
  (cond ((and (>= x 0) (>= y 0))
            (* (expt 2 x) (expt 3 y)))
        (else (error "x and y must greater or equal 0"))))

(define (car z) (devide-x-times z 2))
(define (cdr z) (devide-x-times z 3))

(car (cons 2 3))
(cdr (cons 2 3))
(car (cons 9 12))
(cdr (cons 9 12))
(car (cons 0 0))
(cdr (cons 0 0))
(car (cons 0 2))
(cdr (cons 0 2))
(car (cons 3 0))
(cdr (cons 3 0))