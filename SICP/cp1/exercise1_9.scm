; 这个是递归的计算过程，展开之后计算过程为：
; (*+ 4 5)
; (inc (*+ (dec 4) 5))
; (inc (*+ 3 5))
; (inc (inc (*+ (dec 3) 5)))
; (inc (inc (*+ 2 5)))
; (inc (inc (inc (*+ (dec 2) 5))))
; (inc (inc (inc (*+ 1 5))))
; (inc (inc (inc (inc (*+ (dec 1) 5)))))
; (inc (inc (inc (inc (*+ 0 5)))))
; (inc (inc (inc (inc 5))))
; (inc (inc (inc 6)))
; (inc (inc 7))
; (inc 8)
; 9
(define (*+ a b)
  (if (= a 0)
     b
     (inc (*+ (dec a) b))))

; 这个是迭代的计算过程,展开之后计算过程为:
; (i+ 4 5)
; (i+ (dec 4) (inc 5))
; (i+ 3 6)
; (i+ (dec 3) (inc 6))
; (i+ 2 7)
; (i+ (dec 2) (inc 7))
; (i+ 1 8)
; (i+ (dec 1) (inc 8))
; (i+ 0 9)
; 9
(define (i+ a b)
  (if (= a 0)
     b
     (i+ (dec a) (inc b))))

(define (inc n)
  (+ n 1))

(define (dec n)
  (- n 1))
