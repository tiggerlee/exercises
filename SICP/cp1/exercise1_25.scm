#lang sicp

(define (square n)
  (display "square ")(display n)(newline) 
  (* n n))

(define (fast-expt base n)
  (cond ((= n 0) 1)
	((even? n) (square (fast-expt base (/ n 2))))
  (else (* base (fast-expt base (- n 1))))))

(define (expmod base exp m)
  (remainder (fast-expt base exp) m))

(define (new-expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp) (remainder (square (new-expmod base (/ exp 2) m)) m))
        (else (remainder (* base (new-expmod base (- exp 1) m)) m))))

; 实际运行测试，使用 fast-expt 计算一个很大次幂的结果的时候，用时很久。使用替代法分析，使用 fast-expt 会涉及非常大的数值运算，导致用时比较久，而是用 expomd 
; 则将运算保持在一个不大于 m 次幂的一个范围内，计算效率更高。
(new-expmod 4 11 11)
; (remainder (* 4 (new-expmod 4 10 11)) 11)
; (remainder (* 4 (remainder (square (new-expmod 4 5 11)) 11)) 11)
; (remainder (* 4 (remainder (square (remainder (* 4 (new-expmod 4 4 11)) 11)) 11)) 11)
; (remainder (* 4 (remainder (square (remainder (* 4 (remainder (square (new-expmod 4 2 11)) 11)) 11)) 11)) 11)
; (remainder (* 4 (remainder (square (remainder (* 4 (remainder (square (remainder (square (new-expmod 4 1 11)) 11)) 11)) 11)) 11)) 11)
; (remainder (* 4 (remainder (square (remainder (* 4 (remainder (square (remainder (square (remainder (* 4 (new-expmod 4 0 11)) 11)) 11)) 11)) 11)) 11)) 11)
; (remainder (* 4 (remainder (square (remainder (* 4 (remainder (square (remainder (square (remainder (* 4 1) 11)) 11)) 11)) 11)) 11)) 11)
; (remainder (* 4 (remainder (square (remainder (* 4 (remainder (square (remainder (square (remainder 4 11)) 11)) 11)) 11)) 11)) 11)
; (remainder (* 4 (remainder (square (remainder (* 4 (remainder (square (remainder (square 4) 11)) 11)) 11)) 11)) 11)
; (remainder (* 4 (remainder (square (remainder (* 4 (remainder (square (remainder 16 11)) 11)) 11)) 11)) 11)
; (remainder (* 4 (remainder (square (remainder (* 4 (remainder (square 5) 11)) 11)) 11)) 11)
; (remainder (* 4 (remainder (square (remainder (* 4 (remainder 25 11)) 11)) 11)) 11)
; (remainder (* 4 (remainder (square (remainder (* 4 3) 11)) 11)) 11)
; (remainder (* 4 (remainder (square (remainder 12 11)) 11)) 11)
; (remainder (* 4 (remainder (square 1) 11)) 11)
; (remainder (* 4 (remainder 1 11)) 11)
; (remainder (* 4 1) 11)
; (remainder 4 11)
; 4

(expmod 4 11 11)
; (remainder (fast-expt 4 11) 11)
; (remainder (* 4 (fast-expt 4 10)) 11)
; (remainder (* 4 (square (fast-expt 4 5))) 11)
; (remainder (* 4 (square (* 4 (fast-expt 4 4)))) 11)
; (remainder (* 4 (square (* 4 (square (fast-expt 4 2))))) 11)
; (remainder (* 4 (square (* 4 (square (square (fast-expt 4 1)))))) 11)
; (remainder (* 4 (square (* 4 (square (square (* 4 (fast-expt 4 0))))))) 11)
; (remainder (* 4 (square (* 4 (square (square (* 4 1)))))) 11)
; (remainder (* 4 (square (* 4 (square (square 4))))) 11)
; (remainder (* 4 (square (* 4 (square 16)))) 11)
; (remainder (* 4 (square (* 4 256))) 11)
; (remainder (* 4 (square 1024)) 11)
; (remainder 4194304 11)
; 4