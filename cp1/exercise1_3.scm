(define (square x)
  (* x x))

(define (sum-of-squares x y)
  (+ (square x) 
       (square y)))

(define (max-of-two-nums x y)
  (if (> x y) x y))

(define (f x y z)
  (if (> x y)
     (sum-of-squares x (max-of-two-nums y z))
     (sum-of-squares y (max-of-two-nums x z))))

(f 1 2 3)
(f 1 3 2)
(f 3 2 1)
(f 2 1 3)
(f 2 3 1)
(f 3 1 2)
(f 3 3 3)
(f 3 3 4)
(f 3 4 3)
(f 4 3 3)
  