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
(define (add-streams s1 s2)
  (stream-map + s1 s2))
(define (scale-stream stream factor)
  (stream-map (lambda (x) (* factor x)) stream))

(define (integtal integrand initial-value dt)
  (define int
    (cons-stream initial-value
                 (add-streams (scale-stream integrand dt)
                              int)))
  int)

(define (RC R C dt)
  (lambda (I V)
    (add-streams (scale-stream I R)
                 (integtal (scale-stream I (/ 1 C)) V dt))))

(define I (cons-stream 10 (scale-stream I 1.1)))
(define RC1 (RC 5 1 0.5))
(define RC-stream (RC1 I 5))
(stream-display (stream-head I 10))
(stream-display (stream-head RC-stream 10))