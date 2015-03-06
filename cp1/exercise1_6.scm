; 如果使用书中给出的new-if定义来求平方根的话，会出现递归无法结束直至内存耗尽
; 原因请参考这位大神给出的答案http://sicp.readthedocs.org/en/latest/chp1/6.html
; 主要原因就是书中定义的new-if是一个普通函数，在应用序的解释器中
; 不管提交是否真假，两个clause都会被求值，导致递归无法结束
(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
       guess
       (sqrt-iter (improve guess x)
                        x)))

(define (average x y)
  (/ (+ x y) 2))

(define (good-enough? guess x)
  (if (< (abs (- x (* guess guess))) 0.00001)
       #t
       #f))

(define (improve guess x)
  (average guess (/ x guess)))

(define (mysqrt x)
  (sqrt-iter 1.0 x))

(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
             (else else-clause)))

(mysqrt 2)