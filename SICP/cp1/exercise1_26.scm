#lang sicp

; 使用 square 在幂为偶数式可以减少一次 expmod 调用，改成使用普通乘法，又回到了两次调用，使得复杂度回到了 O(n)
(define (expmod base exp m)
   (cond ((= exp 0) 1)
         ((even? exp) (remainder (* (expmod base (/ exp 2) m)
                                    (expmod base (/ exp 2) m))
                                 m))
         (else (remainder (* base 
                             (expmod base (- exp 1) m)) 
                          m))))

(expmod 75 100 7)