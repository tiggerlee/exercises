(define (sqrt-iter guess x)
  (if (good-enough? guess x)
       guess
       (sqrt-iter (improve guess x)
                        x)))

(define (average x y)
  (/ (+ x y) 2))

(define (good-enough? guess x)
  (< (abs (- (improve guess x) guess))
     (* guess 0.001)))

(define (improve guess x)
  (average guess (/ x guess)))

(define (mysqrt x)
  (sqrt-iter 1.0 x))

(mysqrt 0.000000009)
(mysqrt 4)
(mysqrt 2)
(mysqrt 900000000000000000000000000000000000000000000000)
