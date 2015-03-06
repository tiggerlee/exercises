(define (cbrt-iter guess x)
  (if (good-enough? guess x)
       guess
       (cbrt-iter (improve guess x)
                        x)))

(define (good-enough? guess x)
  (if (< (abs (- guess (improve guess x))) 0.0000000000000000000000001)
       #t
       #f))

(define (improve guess x)
  (/ (+ (/ x (* guess guess)) (* 2 guess))
      3))

(define (cbrt x)
  (cbrt-iter 1.0 x))

(define (cube x)
  (* x x x))

(cbrt (cube 0.333323423412))
(cbrt (cube 99999999999999))
(cbrt 8)
(cbrt -0.0000000000008)
(cbrt 80000000000000000000000000000000000000000000000000)