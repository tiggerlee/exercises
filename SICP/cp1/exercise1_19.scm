#lang sicp

; 请参考 http://community.schemewiki.org/?sicp-ex-1.19
(define (fib-iter a b p q count)
    (cond ((= count 0) b)
          ((even? count)
            (fib-iter a
                      b
                      (+ (* p p) (* q q))
                      (+ (* 2 p q) (* q q))
                      (/ count 2)))
          (else
            (fib-iter (+ (* b q)
                         (* a q)
                         (* a p))
                      (+ (* b p)
                         (* a q))
                      p
                      q
                      (- count 1)))))

(define (fib n)
    (fib-iter 1 0 0 1 n))


(fib 0)
(fib 1)
(fib 2)
(fib 3)
(fib 4)
(fib 5)
(fib 6)
(fib 7)