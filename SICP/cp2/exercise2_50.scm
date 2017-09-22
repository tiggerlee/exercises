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