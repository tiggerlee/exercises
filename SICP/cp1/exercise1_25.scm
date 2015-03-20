; 在使用了fast-expt之后，在求大于100000的素数的时候，会非常慢
; 因为这个计算过程要先计算出来一个数的100000次幂的值
(define (expmod base exp m)
  (remainder (fast-expt base exp) m))

  
(define (fast-expt base n)
  (cond ((= n 0) 1)
	((even? n) (square (fast-expt base (/ n 2))))
	(else (* base (fast-expt base (- n 1))))))

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
