(define (miller-rabin-expmod base exp m)
  (cond ((= exp 0) 1)
	((nontrivial-square-root? base m) 0)
	((even? exp)
	 (remainder (square (miller-rabin-expmod base (/ exp 2) m))
		    m))
	(else
	 (remainder (* base (miller-rabin-expmod base (- exp 1) m))
		    m))))

(define (nontrivial-square-root? base m)
  (and (not (= base 1))
       (not (= base (- m 1)))
       (= 1 (remainder (square base) m))))

(define (miller-rabin-test n)
  (define (iter times)
    (cond ((= times 0) #t)
	  ((= (miller-rabin-expmod (+ 1 (random (- n 1))) (- n 1) n) 1) (iter (- times 1)))
	  (else #f)))
  (iter (ceiling (/ n 2))))

;1 ]=> (miller-rabin-test 13)
;Value: #t

;1 ]=> (miller-rabin-test 1105)
;Value: #f

;1 ]=> (miller-rabin-test 561)
;Value: #f

;1 ]=> (miller-rabin-test 7)
;Value: #t

;1 ]=> (miller-rabin-test 12)
;Value: #f
