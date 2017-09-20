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

(define empty-board nil)

; 使用 ((1 2) (3 4)) 这种格式表示皇后的位置
(define (adjoin-position new-row k rest-of-queens)
  (cons (list new-row k) rest-of-queens))

(define (safe? col-k positions)
  (let ((current-queen (car positions))
        (rest-of-queens (cdr positions)))
    (let ((row-k (car current-queen)))
      (null?
        (filter
          (lambda (position)
            (let ((row (car position))
                  (col (cadr position)))
              (or (= row row-k)
                  (= (abs (- row row-k)) (abs (- col col-k))))))
          rest-of-queens)))))

(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
        (list empty-board)
        (filter
          (lambda (positions)
            (safe? k positions))
          (flatmap
            (lambda (rest-of-queens)
              (map (lambda (new-row)
                     (adjoin-position
                        new-row
                        k
                        rest-of-queens))
                    (interval 1 board-size)))
            (queen-cols (- k 1))))))
  (queen-cols board-size))

(for-each (lambda (x) (display x) (newline)) (queens 8))