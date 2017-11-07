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

(define (expand num den radix)
  (cons-stream
    (quotient (* num radix) den)
    (expand (remainder (* num radix) den) den radix)))

(define s1 (expand 1 7 10))
; (cons-stream 1 (expand 3 7 10))
; (cons-stream 1 (cons-stream 4 (expand 2 7 10)))
; (cons-stream 1 (cons-stream 4 (cons-stream 2 (expand 6 7 10))))
; (cons-stream 1 (cons-stream 4 (cons-stream 2 (cons-stream 8 (expand 4 7 10)))))
; (cons-stream 1 (cons-stream 4 (cons-stream 2 (cons-stream 8 (cons-stream 5 (expand 5 7 10))))))
; (cons-stream 1 (cons-stream 4 (cons-stream 2 (cons-stream 8 (cons-stream 5 (cons-stream 7 (expand 1 7 10)))))))
; 回到了初始值，所以可以得出会产生 1 4 2 8 5 7 ... 1 4 2 8 5 7 循环的序列
(stream-ref s1 0) ; 1
(stream-ref s1 1) ; 4 
(stream-ref s1 2) ; 2
(stream-ref s1 3) ; 8
(stream-ref s1 4) ; 5
(stream-ref s1 5) ; 7
(stream-ref s1 6) ; 1 
(stream-ref s1 7) ; 4
(stream-ref s1 8) ; 2
(stream-ref s1 9) ; 8

(define s2 (expand 3 8 10))
; (cons-stream 3 (expand 6 8 10))
; (cons-stream 3 (cons-stream 7 (expand 4 8 10)))
; (cons-stream 3 (cons-stream 7 (cons-stream 5 (expand 0 8 10))))
; (cons-stream 3 (cons-stream 7 (cons-stream 5 (cons-stream 0 (expand 0 8 10)))))
; (cons-stream 3 (cons-stream 7 (cons-stream 5 (cons-stream 0 (cons-stream 0 (expand 0 8 10))))))
; 重复 (expand 0 8 10)，所以会产生 3 7 5 0 0 0 0 ... 0 0 0 的序列
(stream-ref s2 0) ; 3
(stream-ref s2 1) ; 7
(stream-ref s2 2) ; 5
(stream-ref s2 3) ; 0
(stream-ref s2 4) ; 0
(stream-ref s2 5) ; 0
(stream-ref s2 6) ; 0
(stream-ref s2 7) ; 0
(stream-ref s2 8) ; 0