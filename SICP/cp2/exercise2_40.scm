#lang sicp
(#%require (lib "27.ss" "srfi"))

(define (square n)
  (* n n))

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
  (try-it (+ 1 (random-integer (- n 1)))))

(define (prime? n)
  (define (fast-prime? n times)
    (cond ((= times 0) #t)
	  ((fermat-test n) (fast-prime? n (- times 1)))
	  (else #f)))
  (fast-prime? n 10))
; define prime?
; -----------------------------------

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (interval low high)
  (if (> low high)
      nil
      (cons low (interval (inc low) high))))

(define (filter fl sequence)
  (cond ((null? sequence) nil)
        ((fl (car sequence)) (cons (car sequence) (filter fl (cdr sequence))))
        (else (filter fl (cdr sequence)))))

(define (flatmap proc seq)
  (accumulate append nil (map proc seq)))

(define (prime-sum? pair)
  (prime? (+ (car pair) (cadr pair))))

(define (make-pair-sum pair)
  (let ((first (car pair))
        (second (cadr pair)))
    (list first second (+ first second))))

(define (unique-pairs n)
  (flatmap (lambda (i)
            (map (lambda (j)
                    (list i j))
                 (interval 1 (- i 1))))
           (interval 1 n)))

(define (prime-sum-pairs n)
  (map make-pair-sum
       (filter
        prime-sum?
        (unique-pairs n))))

(prime-sum-pairs 8)