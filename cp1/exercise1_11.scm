; 递归版本
(define (f n)
  (cond ((< n 3) n)
             (else (+ (* 3 (f (- n 3))) (* 2 (f (- n 2))) (f (- n 1))))))

; 迭代版本 我参考了community.schemewiki.org/?sicp-ex-1.11 这个答案
(define (f-iter n)
  (define (iter f0 f1 f2 n)
    (cond ((< n 0) n)
               ((= n 0) f0)
               (else (iter f1 f2 (+ (* 3 f0) (* 2 f1) f2) (- n 1)))))
  (iter 0 1 2 n))


(f 0)
(f 1)
(f 2)
(f 3)
(f 4)
(f 5)
(f 6)

(f-iter 0)
(f-iter 1)
(f-iter 2)
(f-iter 3)
(f-iter 4)
(f-iter 5)
(f-iter 6)