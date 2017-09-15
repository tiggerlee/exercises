#lang sicp

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (accumulate-n op init seqs)
  (define (first-item-in-seqs s)
    (map car s))
  (define (rest-item-in-seqs s)
    (map cdr s))
  (if (null? (car seqs))
      nil
      (cons (accumulate op init (first-item-in-seqs seqs))
            (accumulate-n op init (rest-item-in-seqs seqs)))))

(define (dot-product v w)
  (accumulate + 0 (map * v w)))
(dot-product (list 1 2 3) (list 4 5 6)) 

(define (matrix-*-vector m v)
  (map (lambda (col)
          (dot-product col v))
       m))
(define matrix (list (list 1 2 3 4) (list 5 6 7 8) (list 9 10 11 12)))
(matrix-*-vector matrix (list 2 3 4 5))  

(define (transpose mat)
  (accumulate-n cons '() mat))
(transpose matrix) 

(define (matrix-*-matrix m n) 
  (let ((n-cols (transpose n))) 
    (map (lambda (m-row) (matrix-*-vector n-cols m-row)) 
          m))) 
(matrix-*-matrix matrix (list (list 1 2) (list 1 2) (list 1 2) (list 1 2))) 