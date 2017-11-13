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

(define (sign-change-detector input last-value)
  (cond ((and (>= input 0) (< last-value 0))
          1)
        ((and (< input 0) (>= last-value 0))
          -1)
        (else 0)))

(define (make-zero-crossings input-stream last-value last-avpt)
  (let ((avpt (/ (+ (stream-car input-stream) last-value) 2.0)))
    (cons-stream
      (sign-change-detector
        avpt
        last-avpt)
      (make-zero-crossings
        (stream-cdr input-stream)
        (stream-car input-stream)
        avpt))))

(define test-stream (cons-stream 1 (cons-stream -2 (cons-stream 3 (cons-stream -4 test-stream)))))
(stream-display (stream-head test-stream 10))
(stream-display (stream-head (make-zero-crossings test-stream 0 0) 10))