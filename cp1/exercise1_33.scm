(load "exercise1_28.scm")

(define (prime? x)
  (miller-rabin-test x))

(define (filtered-accumulate combiner null-value term a next b filter)
  (if (> a b)
      null-value
      (if (filter a)
	  (combiner (term a)
		    (filtered-accumulate combiner
					 null-value
					 term
					 (next a)
					 next
					 b
					 filter))
	  (combiner null-value
		    (filtered-accumulate combiner
					 null-value
					 term
					 (next a)
					 next
					 b
					 filter)))))

(define (sum-primes a b)
  (define (term x) x)
  (define (next x) (+ x 1))
  (filtered-accumulate + 0 term a next b prime?))

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (sum-gcd-filter a b)
  (if (< a b)
      (= (gcd a b) 1)
      #f))

(define (sum-gcd-one a b)
  (define (term x) x)
  (define (next x) (+ x 1))
  (filtered-accumulate * 1 term a next b (lambda (x) (sum-gcd-filter x b))))
