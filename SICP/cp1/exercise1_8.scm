(define (cube-root-iter guess prev-guess x)
  (if (good-enough? guess prev-guess)
      guess
      (cube-root-iter (improve guess x) guess x)))

(define (good-enough? guess prev-guess)
  (< (abs (- guess prev-guess))
     (abs (* guess 0.001))))

(define (improve guess x)
  (define (square x)
    (* x x))
  (/ (+ (/ x
	   (square guess))
	(* 2 guess))
     3))

(define (cube-root x)
  (cube-root-iter 1.0 0.0 x))
