#lang sicp

(define (stream-car stream)
  (car stream))

(define (stream-cdr stream)
  (force (cdr stream)))

(define (stream-map proc stream)
  (if (stream-null? stream)
      the-empty-stream
      (cons-stream (proc (stream-car stream))
                   (stream-map proc (stream-cdr stream)))))

(define (stream-enumerate-interval low high)
  (if (> low high)
      the-empty-stream
      (cons-stream
        low
        (stream-enumerate-interval (+ low 1)
                                   high))))

(define (stream-display stream)
  (if (stream-null? stream)
      'done
      (begin (display-line (stream-car stream))
             (stream-display (stream-cdr stream)))))

(define (display-line item)
  (newline)
  (display item))

(define (show x)
  (display-line x)
  x)

(define (stream-ref stream n)
  (if (= n 0)
      (stream-car stream)
      (stream-ref (stream-cdr stream) (- n 1))))

(define (stream-filter pred stream)
  (cond ((stream-null? stream)
          the-empty-stream)
        ((pred (stream-car stream))
          (cons-stream
            (stream-car stream)
            (stream-filter pred (stream-cdr stream))))
        (else
          (stream-filter
            pred
            (stream-filter pred (stream-cdr stream))))))

(define sum 0)
sum ; 0
(define (accum x)
  (set! sum (+ x sum))
  sum)
sum ; 0
(define seq (stream-map accum (stream-enumerate-interval 1 20)))
sum ; 1
(define y (stream-filter even? seq))
sum ; 6
(define z (stream-filter (lambda (x) (= (remainder x 5) 0))
                         seq))
sum ; 10
(stream-ref y 7)
sum ; 136
(stream-display z)
sum ; 210