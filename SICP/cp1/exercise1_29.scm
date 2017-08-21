#lang sicp

(define (cube x)
  (* x x x))

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
	       (sum term (next a) next b))))

(define (integral f a b dx)
  (define (add-dx x) 
    (+ x dx))
  (* (sum f (+ a (/ dx 2.0)) add-dx b) dx))

; 解答参考 http://sicp.readthedocs.io/en/latest/chp1/29.html
(define (simpson f a b n)
  (define h (/ (- b a) n))
  (define (y k)
    (f (+ a (* k h))))
  (define (factor k)
    (cond ((or (= k 0) (= k n)) 1)
	        ((odd? k) 4)
	        (else 2)))
  (define (term k)
    (* (factor k)
       (y k)))
  (if (not (even? n))
      (display "n can't be odd")
      (* (/ h 3)
         (sum term (exact->inexact 0) inc n))))
                
(integral cube 0 1 0.01) ; 0.24998750000000042
(integral cube 0 1 0.001); 0.249999875000001
(simpson cube 0 1 100)   ; 0.24999999999999992
(simpson cube 0 1 1000)  ; 0.2500000000000003
(simpson cube 0 1 999)   ; n can't be odd