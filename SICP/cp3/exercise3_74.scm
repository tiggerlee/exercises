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

(define (make-zero-crossings input-stream last-value)
  (cons-stream
    (sign-change-detector
      (stream-car input-stream)
      last-value)
    (make-zero-crossings
      (stream-cdr input-stream)
      (stream-car input-stream))))

(define (make-zero-crossings-use-map input-stream last-value)
  (stream-map sign-change-detector 
              input-stream 
              (cons-stream last-value input-stream)))

(define positive-ones (cons-stream 1 positive-ones))
(define negative-ones (stream-map (lambda (x) (* x -1)) positive-ones))
(define mix-ones (cons-stream 1 (stream-map (lambda (x) (* x -1)) mix-ones)))
(stream-display (stream-head (make-zero-crossings positive-ones 0) 10))
(stream-display (stream-head (make-zero-crossings negative-ones 0) 10))
(stream-display (stream-head (make-zero-crossings mix-ones 0) 10))
(stream-display (stream-head (make-zero-crossings-use-map positive-ones 0) 10))
(stream-display (stream-head (make-zero-crossings-use-map negative-ones 0) 10))
(stream-display (stream-head (make-zero-crossings-use-map mix-ones 0) 10))