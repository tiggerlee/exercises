#lang sicp

(define (square n)
  (* n n))

(define (expt b n)
  (define (eiter product b counter)
    (cond ((= counter 0) product)
          ((even? counter) (eiter product
                                  (square b)
                                  (/ counter 2)))
          (else (eiter (* product b) 
                       b
                       (- counter 1)))))
  (eiter 1 b n))

; 解法我参考了http://community.schemewiki.org/?sicp-ex-1.16
; (expt 3 4)
; (eiter 1 3 4)
; (eiter 1 9 2)
; (eiter 1 81 1)
; (eiter 81 81 0)
; 81

; (expt 2 10)
; (eiter 1 2 10)
; (eiter 1 4 5)
; (eiter 4 4 4)
; (eiter 4 16 2)
; (eiter 4 256 1)
; (eiter 1024 256 0)
; 1024
    

(expt 3 3)
(expt 3 0)
(expt 3 1)
(expt 3 4)
(expt 3 100)
(expt 2 10)
