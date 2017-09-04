#lang sicp
; 按照下图所示，分为三层，在修改其中一层的实现时，其他层不需要做修改
; -------------------------
; area perimeter
; -------------------------
; make-rectagle top-left bottom-right long tall
; ----------------------------------------------
; make-point x-point y-point

(define (make-point x y)
  (cons x y))

(define (x-point p)
  (car p))

(define (y-point p)
  (cdr p))

(define (make-rectagle top-left bottom-right)
  (cons top-left bottom-right))

(define (top-left rectagle)
  (car rectagle))

(define (bottom-right rectagle)
  (cdr rectagle))

(define (long rectagle)
  (abs (- (x-point (top-left rectagle))
          (x-point (bottom-right rectagle)))))

(define (tall rectagle)
  (abs (- (y-point (top-left rectagle))
          (y-point (bottom-right rectagle)))))

(define (area rectagle)
  (* (long rectagle)
     (tall rectagle)))

(define (perimeter rectagle)
  (* 2 (+ (long rectagle)
          (tall rectagle))))

(define rectagle1 (make-rectagle (make-point 0 0) (make-point 4 8)))
(area rectagle1)
(perimeter rectagle1)

(define rectagle2 (make-rectagle (make-point 1 3) (make-point 4 8)))
(area rectagle2)
(perimeter rectagle2)