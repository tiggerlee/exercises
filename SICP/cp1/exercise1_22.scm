#lang sicp


; 在我的计算机上运行结果如最下面的注释所示
; 结果为 1 3 8 17
; 刚开始比较接近(sqrt 10)的增长速度，随着数字增加误差开始增大
(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
	((divides? test-divisor n) test-divisor)
	(else (find-divisor n (+ 1 test-divisor)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

(define (next-odd n)
  (if (odd? n)
      (+ n 2)
      (+ n 1)))

(define (find-prime n c)
  (let ((a 0))
    (cond ((= a c) (display "Done"))
	  ((prime? n)
	   (display n)
	   (newline)
	   (find-prime (next-odd n) (- c 1)))
	  (else (find-prime (next-odd n) c)))))

(define (time-prime-test n)
  (let ((start-time (real-time-clock)))
    (find-prime n 3)
    (newline)
    (display (- (real-time-clock) start-time))))


; 1 ]=> (load "exercise1_22.scm")


; 1 ]=> (time-prime-test 1000)
; 1009
; 1013
; 1019
; Done
; 1


; 1 ]=> (time-prime-test 10000)
; 10007
; 10009
; 10037
; Done
; 3


; 1 ]=> (time-prime-test 100000)
; 100003
; 100019
; 100043
; Done
; 8


; 1 ]=> (time-prime-test 1000000)
; 1000003
; 1000033
; 1000037
; Done
; 17
