#lang sicp

(define (make-vect x-cor y-cor)
  (list x-cor y-cor))

(define (xcor-vect vector)
  (car vector))

(define (ycor-vect vector)
  (cadr vector))

(define (add-vect vect1 vect2)
  (make-vect (+ (xcor-vect vect1) (xcor-vect vect2))
             (+ (ycor-vect vect1) (ycor-vect vect2))))

(define (sub-vect vect1 vect2)
  (make-vect (- (xcor-vect vect1) (xcor-vect vect2))
             (- (ycor-vect vect1) (ycor-vect vect2))))

(define (scale-vect vector scale)
  (make-vect (* (xcor-vect vector) scale)
             (* (ycor-vect vector) scale)))

(define vect1 (make-vect 0.5 0.5))
(define vect2 (make-vect 0.2 0.3))
(display vect1) ; (0.5 0.5)
(newline)
(display vect2) ; (0.2 0.3)
(newline)
(display (add-vect vect1 vect2)) ; (0.7 0.8)
(newline)
(display (sub-vect vect1 vect2)) ; (0.3 0.2)
(newline)
(display (scale-vect vect2 2.0)) ; (0.4 0.6)