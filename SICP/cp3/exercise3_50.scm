#lang sicp

(define (memo-proc proc)
  (let ((already-run? false) (result false))
    (lambda ()
      (if (not already-run?)
          (begin (set! result (proc))
                 (set! already-run? true)
                 result)
          result))))

(define (delay exp)
  (memo-proc (lambda () exp)))

(define (force delayed-object)
  (delayed-object))

(define (stream-cons a b)
  (cons a (delay b)))

(define the-empty-stream '())

(define (stream-null? stream)
  (null? stream))

(define (stream-car stream)
  (car stream))

(define (stream-cdr stream)
  (force (cdr stream)))

(define (stream-map proc . argstreams)
  (if (stream-null? (car argstreams))
      the-empty-stream
      (stream-cons
       (apply proc (map stream-car argstreams))
       (apply stream-map
              (cons proc (map stream-cdr argstreams))))))

(define (stream-enumerate-interval low high)
  (if (> low high)
      the-empty-stream
      (stream-cons
       low
       (stream-enumerate-interval (+ low 1) high))))

(define (stream-display stream)
  (if (stream-null? stream)
      'done
      (begin (display-line (stream-car stream))
             (stream-display (stream-cdr stream)))))

(define (display-line item)
  (newline)
  (display item))

(define one-to-five (stream-enumerate-interval 1 5))
(define six-to-ten (stream-enumerate-interval 6 10))
(stream-display (stream-map + one-to-five six-to-ten))
