#lang sicp

; 递归版本
(define (cont-frac n d k)
  (define (compute index)
    (if (> index k)
        1
        (/ (n index) (+ (d index) (compute (inc index))))))
  (compute 1))

; 迭代版本，解答参考了 http://community.schemewiki.org/?sicp-ex-1.37 http://sicp.readthedocs.io/en/latest/chp1/37.html
(define (cont-frac-iter n d k)
  (define (compute index result)
    (if (< index 0)
        result
        (compute (dec index) (/ (n index)
                                (+ (d index) result)))))
  (compute k 0))
    
; 0.6180555555555556 
(cont-frac (lambda (i) 1.0)
           (lambda (i) 1.0)
           10)
; 0.6180555555555556
(cont-frac-iter (lambda (i) 1.0)
                (lambda (i) 1.0)
           10)