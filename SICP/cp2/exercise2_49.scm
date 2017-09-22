#lang sicp

; 1
(define top-left (make-vect 0.0 1.0))
(define top-right (make-vect 1.0 1.0))
(define bottom-left (make-vect 0.0 0.0))
(define bottom-right (make-vect 1.0 0.0))
(define top (make-segment top-left top-right))
(define left (make-segment top-left bottom-left))
(define right (make-segment top-right bottom-right))
(define bottom (make-segment bottom-left bottom-right))
(segments->painter (list top bottom left right))

; 2
(define top-left-to-buttom-right (make-segment top-left bottom-right))
(define top-right-to-bottom-left (make-segment top-right bottom-left))
(segments->painter (list top-left-to-buttom-right top-right-to-bottom-left))

; 3
(define top-mid-to-right-mid (make-segment (make-vect 0.5 1.0)
                                           (make-vect 1.0 0.5)))
(define top-mid-to-left-mid (make-segment (make-vect 0.5 1.0)
                                           (make-vect 0.0 0.5)))
(define bottom-mid-to-right-mid (make-segment (make-vect 0.5 0.0)
                                           (make-vect 1.0 0.5)))
(define bottom-mid-to-left-mid (make-segment (make-vect 0.5 0.0)
                                           (make-vect 0.0 0.5)))

(segments->painter (list top-mid-to-left-mid
                         top-mid-to-right-mid
                         bottom-mid-to-left-mid
                         bottom-mid-to-right-mid))