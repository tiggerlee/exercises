(define tolerance 0.00001)

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (display guess)
    (newline)
    (let ((next (f guess)))
      (if (close-enough? guess next)
	  next
	  (try next))))
  (try first-guess))

(define (f x)
  (fixed-point (lambda (x) (/ (log 1000) (log x))) x))

(define (average x y)
  (/ (+ x y) 2.0))

(define (f-with-average x)
  (fixed-point (lambda (x) (average x (/ (log 1000) (log x)))) x))
