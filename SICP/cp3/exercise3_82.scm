#lang sicp
(#%require (lib "27.ss" "srfi"))

(define (stream-car stream)
  (car stream))

(define (stream-cdr stream)
  (force (cdr stream)))

(define (stream-map proc . argstreams)
  (if (stream-null? (car argstreams))
      the-empty-stream
      (cons-stream
       (apply proc (map stream-car argstreams))
       (apply stream-map
              (cons proc (map stream-cdr argstreams))))))

(define (stream-head stream n)
  (if (>= n 0)
    (cons-stream (stream-car stream) (stream-head (stream-cdr stream) (- n 1)))
    the-empty-stream))

(define (stream-display stream)
  (if (stream-null? stream)
      'done
      (begin (display-line (stream-car stream))
             (stream-display (stream-cdr stream)))))

(define (stream-ref stream n)
  (if (= n 0)
      (stream-car stream)
      (stream-ref (stream-cdr stream) (- n 1))))

(define (display-line item)
  (newline)
  (display item))

(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (random-integer range) (random-real))))

(define (P x y)
  (<= (+ (expt (- x 5) 2)
         (expt (- y 7) 2))
      (expt 3 2)))

(define (random-points low high)
  (cons-stream (random-in-range low high)
               (random-points low high)))

(define (estimate-integral x1 x2 y1 y2 P)
  (let ((x-points (random-points x1 x2))
        (y-points (random-points y1 y2)))
    (map-successive-points x-points y-points P)))

(define (map-successive-points x-points y-points P)
  (cons-stream (P (stream-car x-points)
                  (stream-car y-points))
               (map-successive-points
                (stream-cdr x-points)
                (stream-cdr y-points)
                P)))
    
(define (monte-carlo experiment-stream passed failed)
  (define (next passed failed)
    (cons-stream (/ passed
                    (+ passed failed))
                 (monte-carlo
                  (stream-cdr experiment-stream)
                  passed
                  failed)))
  (if (stream-car experiment-stream)
      (next (+ passed 1) failed)
      (next passed (+ failed 1))))

(define pi
  (stream-map (lambda (x)
                (let ((area (* (* (- 8 2)
                                  (- 10 4))
                               x)))
                  (/ area (expt 3.0 2))))
              (monte-carlo (estimate-integral 2 8 4 10 P) 0 0)))

(stream-ref pi 1000000)