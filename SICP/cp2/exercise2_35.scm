#lang sicp

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (count-leaves t)
  (accumulate + 0 (map (lambda (node)
                            (cond ((pair? node) (count-leaves node))
                                  (else 1))) 
                        t)))

(count-leaves (list 1 2 3 (list 4 5 (list 7 8)) 6)) ; 8
(count-leaves '()) ; 0