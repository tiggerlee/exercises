#lang sicp

(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeats f n)
    (if (= n 1)
        f
        (compose f (repeats f (- n 1)))))

(define (square n)
  (* n n))

(define (expt b n)
  (define (eiter product b counter)
    (cond ((= counter 0) product)
          ((even? counter) (eiter product
                                  (square b)
                                  (/ counter 2)))
          (else (eiter (* product b) 
                       b
                       (- counter 1)))))
  (eiter 1 b n))

(define (average x y)
  (/ (+ x y) 2.0))

(define (average-damp f)
  (lambda (x) (average x (f x))))

(define (average-damp-n-times f n)
  ((repeats average-damp n) f))

(define (fixed-point f first-guess)
  (define tolerance 0.00001)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

(define (nth-root n damp-times)
  (lambda (x)
    (fixed-point 
      (average-damp-n-times 
        (lambda (y) 
          (/ x 
            (expt y (- n 1)))) 
        damp-times) 
      2.0)))

; 解答参考了 http://sicp.readthedocs.io/en/latest/chp1/45.html
; 求 n 次方根，需要 (lg n) 次 average-damp
; ((nth-root 2 0) 4) ; cant evalute
((nth-root 2 1) 4)
; ((nth-root 4 1) (* 4 4 4 4)) ; cant evalute
((nth-root 4 2) (* 4 4 4 4))
((nth-root 5 2) (* 4 4 4 4 4))
((nth-root 6 2) (* 4 4 4 4 4 4))
((nth-root 7 2) (* 4 4 4 4 4 4 4))
; ((nth-root 8 2) (* 4 4 4 4 4 4 4 4)) ; cant evalute
((nth-root 8 3) (* 4 4 4 4 4 4 4 4))