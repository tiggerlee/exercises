#lang sicp

(define first (list 1 3 (list 5 7) 9))
(define second (list (list 7)))
(define third (list 1 (list 2 (list 3 (list 4 (list 5 (list 6 7)))))))

(car (cdr (car (cdr (cdr first)))))
(car (car second))
(car (cdr (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr third))))))))))))