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

(accumulate-n + 0 (list (list 1 2 3) (list 4 5 6) (list 7 8 9) (list 10 11 12)))