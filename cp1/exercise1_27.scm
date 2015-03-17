(define (expmod base exp m)
  (cond ((= exp 0) 1)
	((even? exp)
	 (remainder (square (expmod base (/ exp 2) m))
		    m))
	(else
	 (remainder (* base (expmod base (- exp 1) m))
		    m))))

(define (full-fermat-test n)
  (define (iter n i)
    (cond ((= n i)
	   (display " Carmichael number ")
	   (newline))
	  ((= (expmod i n n) i) (iter n (+ i 1)))
	  (else
	   (display " Not Carmichael number ")
	   (newline))))
  (iter n 1))

(define (is-carmichael-number n)
  (full-fermat-test n))

; 1 ]=> (is-carmichael-number 561)
; Carmichael number

; 1 ]=> (is-carmichael-number 1105)
; Carmichael number

; 1 ]=> (is-carmichael-number 1729)
; Carmichael number

; 1 ]=> (is-carmichael-number 2465)
; Carmichael number

; 1 ]=> (is-carmichael-number 2821)
; Carmichael number

; 1 ]=> (is-carmichael-number 6601)
; Carmichael number


