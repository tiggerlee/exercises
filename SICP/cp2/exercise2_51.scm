#lang sicp

(define (flip-horiz painter)
  (transfrom-painter painter
                     (make-vect 1.0 0.0)
                     (make-vect 0.0 0.0)
                     (make-vect 1.0 1.0)))

; 逆时针旋转180
(define (anti-rotate-180 painter)
  (transfrom-painter painter
                     (make-vect 1.0 1.0)
                     (make-vect 0.0 1.0)
                     (make-vect 1.0 0.0)))
; 逆时针旋转270
(define (anti-rotate-180 painter)
  (transfrom-painter painter
                     (make-vect 0.0 1.0)
                     (make-vect 0.0 0.0)
                     (make-vect 1.0 1.0)))

(define (below pb pt)
  (let ((split-point (make-vect 0.0 0.5)))
    (let ((paint-top 
            (transfrom-painter pt
                               split-point
                               (make-vect 0.0 1.0)
                               (make-vect 1.0 0.5)))
          (paint-bottom
            (transfrom-painter pb
                               (make-vect 0.0 0.0)
                               split-point
                               (make-vect 1.0 0.0))))
      (lambda (frame)
        (paint-top frame)
        (paint-bottom frame)))))

(define (below-use-beside p1 p2)
  (lambda (frame)
    ((flip-horiz
      (anti-rotate-90
        (beside
          (anti-rotate-270
            (flip-horiz painter1))
          (anti-rotate-270
            (flip-horiz painter2)))))
  frame)))