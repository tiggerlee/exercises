; a
(define (product term a next b)
  (if (> a b)
      1
      (* (term a)
	 (product term (next a) next b))))

(define (fac n)
  (define (term x) x)
  (define (next x) (+ x 1))
  (product term 1 next n))

(define (next n)
  (+ n 1))

(define (pi-term n)
  (if (even? n)
      (/ (+ n 2) (+ n 1))
      (/ (+ n 1) (+ n 2))))

(define (pi n)
  (* 4.0 (product-i pi-term 1 next n)))

; b
(define (product-i term a next b)
  (define (iter a result)
    (if (> a b)
	result
	(iter (next a) (* result (term a)))))
  (iter a 1))
