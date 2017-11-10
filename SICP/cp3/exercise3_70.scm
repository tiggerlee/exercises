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

; a
(define (weight_with_sum item)
  (+ (car item) (cadr item)))
(define pairs-stream (pairs integers integers weight_with_sum))
(stream-display (stream-head pairs-stream 100))

; b
(define no_235_divide
  (stream-filter (lambda (x)
                   (not (or (divide? x 2)
                            (divide? x 3)
                            (divide? x 5))))
                 integers))

(define 235_stream (pairs 
                     no_235_divide 
                     no_235_divide 
                     (lambda (x)
                       (let ((i (car x)) (j (cadr x)))
                         (+ (* 2 i) (* 3 j) (* 5 i j))))))
(stream-display (stream-head 235_stream 100))
