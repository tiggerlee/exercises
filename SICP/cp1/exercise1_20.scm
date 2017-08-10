#lang sicp

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(gcd 206 40)

; 应用序调用了4次remainder函数
; (gcd 206 40)
; (gcd 40 (remainder 206 40))
; (gcd 40 6)
; (gcd 6 (remainder(40 6)))
; (gcd 6 4)
; (gcd 4 (remainder 6 4))
; (gcd 4 2)
; (gcd 2 (reminder 4 2))
; (gcd 2 0)
; 2


; 正则序， 因为先展开再求值得特性，remainder函数调用远远超过了应用序中的调用。
; (gcd 206 40)
; gcd(gcd 40 (remainder 206 40))
; if (= (remainder(206 40))
; (gcd (remainder 206 40) (remainder 40 (remainder 206 40)))
; (if (= (remainder 40 (remainder 206 40)) 0))
; ...
