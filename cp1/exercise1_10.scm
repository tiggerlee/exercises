(define (A x y)
  (cond ((= y 0) 0)
             ((= x 0) (* 2 y))
             ((= y 1) 2)
             (else (A (- x 1)
                           (A x (- y 1))))))

(define (e n p)
  (if (= p 0)
     n
     (* n (e n (- p 1)))))

(define (f n) (A 0 n))
(define (g n) (A 1 n))
(define (h n) (A 2 n))
(define (k n) (* 5 n n))

(A 1 10)  ; result is 1024
(A 2 4)    ; result is 65536
(A 3 3)    ; result is 65536

; (f n) 求n的2倍，即 n * 2
; (g n) 求2的n次方，即 2^n
; (k n) 求2的2次方的2次方的2次方... 重复n次，请参照这里给出的解答: community.schemewiki.org/?sicp-ex-1.10
