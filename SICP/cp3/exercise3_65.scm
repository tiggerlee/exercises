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
(define (partial-sums s)
  (define inner-stream (cons-stream (stream-car s) (add-streams inner-stream (stream-cdr s))))
  inner-stream)
(define (square x)
  (* x x))

(define (ln2-summands n)
  (cons-stream (/ 1.0 n)
               (stream-map - (ln2-summands (+ n 1)))))
(define ln2-stream (partial-sums (ln2-summands 1)))
; ln2 = 0.693147180559945....
; 使用了上面定义的 ln2-stream，在流的第200项结果为：0.6956285548599337
; 精度只达到了2位小数，收敛速度很慢
(stream-display (stream-head ln2-stream 200))

(define (euler-transform s)
  (let ((s0 (stream-ref s 0))
        (s1 (stream-ref s 1))
        (s2 (stream-ref s 2)))
    (cons-stream (- s2 (/ (square (- s2 s1))
                          (+ s0 (* -2 s1) s2)))
                 (euler-transform (stream-cdr s)))))
; 使用 euler-transform 加速之后，200项结果为：0.6931471956128978
; 可以看到收敛速度明显变快，同样的计算量，精度精确到了七位小数
(define euler-stream (euler-transform ln2-stream))
(stream-display (stream-head euler-stream 200))

; 使用书中提到的 make-tableau 加速方法，第九项的结果为：0.6931471805599454
; 已经收敛到了15位小数的精度
(define (make-tableau transform s)
  (cons-stream s
               (make-tableau transform (transform s))))
(define (accelerated-sequence transform s)
  (stream-map stream-car
              (make-tableau transform s)))
(define accelerated-stream (accelerated-sequence euler-transform ln2-stream))
(stream-display (stream-head accelerated-stream 9))