; 在使用了费马小定理之后对于1000 10000 100000 1000000 10000000的测试结果为：4 5 7 8 9
; 虽然没有严格按照logn的规律增长，但是还在log的范围之中

(define (expmod base exp m)
  (cond ((= exp 0) 1)
	((even? exp)
	 (remainder (square (expmod base (/ exp 2) m))
		    m))
	(else
	 (remainder (* base (expmod base (- exp 1) m))
		    m))))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (prime? n)
  (define (fast-prime? n times)
    (cond ((= times 0) #t)
	  ((fermat-test n) (fast-prime? n (- times 1)))
	  (else #f)))
  (fast-prime? n 10))

(define (next-odd n)
  (if (odd? n)
      (+ n 2)
      (+ n 1)))

(define (find-prime n c)
  (let ((a 0))
    (cond ((= a c) (display "Done"))
	  ((prime? n)
	   (display n)
	   (newline)
	   (find-prime (next-odd n) (- c 1)))
	  (else (find-prime (next-odd n) c)))))

(define (time-prime-test n)
  (let ((start-time (real-time-clock)))
    (find-prime n 3)
    (newline)
    (display (- (real-time-clock) start-time))))
