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

(define (add-streams s1 s2)
  (stream-map + s1 s2))
; 根据定义可以得出，对于 fibs(i) 可由 fibs(i-1) + fibs(i-2) 计算得出
; 由于使用了记忆计算，所以每个 fibs(n) 只需要计算一次，所以复杂度为O(n)
; 如果不使用记忆的方法，那么每次 fibs(i) 需要计算 fibs(i-1) 和 fibs(i-2)
; fibs(i-1) 需要计算 fibs(i-2) 和 fibs(i-3)
; fibs(i-2) 需要计算 fibs(i-3) 和 fibs(i-4)
; 这样会产生重复计算，导致复杂度呈指数增长
(define fibs (cons-stream 0 (cons-stream 1 (add-streams fibs (stream-cdr fibs)))))
(stream-ref fibs 0)
(stream-ref fibs 1)
(stream-ref fibs 2)
(stream-ref fibs 3)
(stream-ref fibs 4)
(stream-ref fibs 5)
(stream-ref fibs 6)
(stream-ref fibs 7)
(stream-ref fibs 8)
(stream-ref fibs 9)
(stream-ref fibs 10)