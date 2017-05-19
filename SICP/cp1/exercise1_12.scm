#lang sicp

; row and col count from 1
(define (pascal row col)
  (cond ((or (= col 1)
             (= row col))
         1)
        (else (+ (pascal (- row 1)
                         (- col 1))
                 (pascal (- row 1)
                         col)))))

(pascal 1 1) ; 1

(pascal 3 1) ; 1
(pascal 3 2) ; 2
(pascal 3 3) ; 1

(pascal 5 1) ; 1
(pascal 5 2) ; 4
(pascal 5 3) ; 6
(pascal 5 4) ; 4
(pascal 5 5) ; 1
