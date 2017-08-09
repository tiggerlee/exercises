#lang sicp

; row and col count from 1
(define (pascal row col)
  (cond 
        ((> col row) "Error: col should not greater than row")
        ((or (<= col 0) (<= row 0)) "Error: row and col should start from 1")
        ((or (= col 1)
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

(pascal 6 3) ; (+ (pascal 5 2) (pascal 5 3)) => 10 

;(pascal 40 30) ; interpreter says that it's 635745396, TL,DR 
