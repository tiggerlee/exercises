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

(define (stream-map proc stream)
  (if (stream-null? stream)
      the-empty-stream
      (stream-cons (proc (stream-car stream))
                   (stream-map proc (stream-cdr stream)))))

(define (stream-enumerate-interval low high)
  (if (> low high)
      the-empty-stream
      (stream-cons
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

(define x (stream-map show (stream-enumerate-interval 0 10)))
(stream-ref x 5)
(stream-ref x 7)