#lang sicp
(#%require (lib "27.ss" "srfi"))

(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (random-integer range) (random-real))))

(define (P x y)
  (<= (+ (expt (- x 5) 2)
         (expt (- y 7) 2))
      (expt 3 2)))

(define (estimate-integral x1 x2 y1 y2 P trials)
  (define (experiment)
    (P (random-in-range x1 x2)
       (random-in-range y1 y2)))
  (monte-carlo trials experiment))
    

(define (monte-carlo trials experiment)
  (define (iter trials-remaining trials-passed)
    (cond ((= trials-remaining 0)
           (/ trials-passed trials))
          ((experiment)
           (iter (- trials-remaining 1) (+ trials-passed 1)))
          (else
           (iter (- trials-remaining 1) trials-passed))))
  (iter trials 0))



(define (pi)
  (let ((area (* (estimate-integral 2 8 4 10 P 1000000)
                 (* (- 8 2) (- 10 4)))))
    (/ area (expt 3.0 2))))

(pi)