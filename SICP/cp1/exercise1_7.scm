(define (sqrt-iter guess x)
  (if (good-enough? guess x)
       guess
       (sqrt-iter (improve guess x)
                        x)))

(define (average x y)
  (/ (+ x y) 2))

(define (good-enough? guess x)
  (if (< (abs (- guess (improve guess x))) 0.0000000000000000000000001)
       #t
       #f))

(define (improve guess x)
  (average guess (/ x guess)))

(define (mysqrt x)
  (sqrt-iter 1.0 x))

(mysqrt 0.000000009)
(mysqrt 4)
(mysqrt 2)
(mysqrt 900000000000000000000000000000000000000000000000)