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

(define (integers-starting-from n)
  (cons-stream n (integers-starting-from (+ n 1))))

(define integers (integers-starting-from 1))

(define (divide? x n)
  (= (remainder x n) 0))
(define (weight_merge s1 s2 w)
  (cond ((stream-null? s1) s2)
        ((stream-null? s2) s1)
        (else
          (let ((s1car (stream-car s1))
                (s2car (stream-car s2)))
            (cond ((< (w s1car) (w s2car))
                    (cons-stream s1car (weight_merge (stream-cdr s1) s2 w)))
                  ((> (w s1car) (w s2car))
                    (cons-stream s2car (weight_merge s1 (stream-cdr s2) w)))
                  (else
                    (cons-stream s1car
                                 (weight_merge (stream-cdr s1)
                                        s2
                                        w))))))))

(define (pairs s t w)
  (cons-stream
    (list (stream-car s) (stream-car t))
    (weight_merge
      (stream-map (lambda (x) (list (stream-car s) x))
                  (stream-cdr t))
      (pairs (stream-cdr s) (stream-cdr t) w)
      w)))

(define (square x) (* x x))
(define (square_sum item)
  (+ (square (car item)) (square (cadr item))))
(define pairs-stream (pairs integers integers square_sum))

(define (squares_number stream count)
  (define (iter stream n)
    (if (> n 0)
      (let ((first (stream-car stream))
            (second (stream-car (stream-cdr stream)))
            (third (stream-car (stream-cdr (stream-cdr stream)))))
        (if (= (square_sum first) (square_sum second) (square_sum third))
            (begin
              (display (square_sum first))
              (display ": ")
              (display first)
              (display second)
              (display third)
              (newline)
              (iter (stream-cdr stream) (- n 1)))
            (squares_number (stream-cdr stream) n)))
      'done))
  (iter stream count))
(squares_number pairs-stream 6)