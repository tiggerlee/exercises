#lang sicp

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (interval low high)
  (if (> low high)
      nil
      (cons low (interval (inc low) high))))

(define (filter fl sequence)
  (cond ((null? sequence) nil)
        ((fl (car sequence)) (cons (car sequence) (filter fl (cdr sequence))))
        (else (filter fl (cdr sequence)))))

(define (flatmap proc seq)
  (accumulate append nil (map proc seq)))

(define (unique-pairs n)
  (flatmap (lambda (i)
            (map (lambda (j)
                    (list i j))
                 (interval 1 (- i 1))))
           (interval 1 n)))

(define (unique-triples n)
  (flatmap (lambda (i)
            (map (lambda (j)
                  (cons i j))
                 (unique-pairs (- i 1))))
           (interval 1 n)))

(define (triple-sum triple)
  (+ (car triple) (cadr triple) (caddr triple)))

(define (f n sum)
  (filter (lambda (triple)
            (= sum (triple-sum triple)))
          (unique-triples n)))

(f 13 10)