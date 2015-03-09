(define (double n)
  (* 2 n))

(define (halve n)
  (/ n 2))

(define (fast-times n m)
  (define (iter a n m)
    (cond
      ((= m 0) a)
      ((even? m) (iter a (double n) (halve m)))
      (else (iter (+ a n) n (- m 1)))))
  (iter 0 n m))

(fast-times 4 5)