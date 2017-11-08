#lang sicp

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

(define (stream-display stream)
  (if (stream-null? stream)
      'done
      (begin (display-line (stream-car stream))
             (stream-display (stream-cdr stream)))))

(define (display-line item)
  (newline)
  (display item))

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

(define (div-streams s1 s2)
  (stream-map / s1 s2))
(define (mul-streams s1 s2)
  (stream-map * s1 s2))
(define (add-streams s1 s2)
  (stream-map + s1 s2))
(define (scale-stream stream factor)
  (stream-map (lambda (x) (* factor x)) stream))

(define (stream-head stream n)
  (if (>= n 0)
      (cons-stream (stream-car stream) (stream-head (stream-cdr stream) (- n 1)))
      the-empty-stream))

(define ones (cons-stream 1 ones))
(define (integers-starting-from n)
  (cons-stream n (integers-starting-from (inc n))))
(define integers (integers-starting-from 1))
(define (integrate-series a)
  (mul-streams a
               (div-streams ones integers)))

(define exp-series (cons-stream 1 (integrate-series exp-series)))
(define sine-series (cons-stream 0 (integrate-series cosine-series)))
(define cosine-series (cons-stream 1 (integrate-series (scale-stream sine-series -1))))

(define (mul-series s1 s2)
  (cons-stream (* (stream-car s1) (stream-car s2))
               (add-streams (scale-stream (stream-cdr s2) (stream-car s1))
                            (mul-series (stream-cdr s1) s2))))

(define s (add-streams (mul-series sine-series sine-series) (mul-series cosine-series cosine-series)))
(stream-display (stream-head s 10))