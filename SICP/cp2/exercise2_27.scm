#lang sicp

(define (reverse x)
  (define (iter l r)
    (if (null? l)
      r
      (iter (cdr l) (cons (car l) r))))
  (iter x nil))

; 使用了reverse的版本
(define (deep-reverse-use-reverse x)
  (define (iter l r)
    (cond ((null? l) r)
          ((pair? (car l)) (iter (cdr l) (cons (reverse (car l)) r)))
          (else (iter (cdr l) (cons (car l) r)))))
  (iter x nil))

; 自身迭代的版本
(define (deep-reverse x)
  (define (iter l r)
    (if (null? l)
        r
        (let ((first (car l)))
            (iter (cdr l) (cons (if (not (pair? first))
                                    first
                                    (deep-reverse first))
                                r)))))
  (iter x nil))


(define x (list (list 1 2) (list 3 4)))  ; ((1 2) (3 4))
(reverse x)                              ; ((3 4) (1 2))
(deep-reverse x)                         ; ((4 3) (2 1))

(deep-reverse (list (list 1 2) (list 3 4) (list 5 6)))