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

(f 1 2 3) ;=(sum-of-squares 2 3)=13
(f 1 3 2) ;=(sum-of-squares 3 2)=13
(f 3 2 1) ;=(sum-of-squares 3 2)=13
(f 2 1 3) ;=(sum-of-squares 2 3)=13
(f 2 3 1) ;=(sum-of-squares 2 3)=13
(f 3 1 2) ;=(sum-of-squares 3 2)=13
(f 3 3 3) ;=(sum-of-squares 3 3)=18
(f 3 3 4) ;=(sum-of-squares 3 4)=25
(f 3 4 3) ;=(sum-of-squares 3 4)=25
(f 4 3 3) ;=(sum-of-squares 4 3)=25
  
