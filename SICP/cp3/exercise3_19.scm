#lang sicp

(define (list-walk lst step)
  (cond ((null? lst) '())
        ((= step 0) lst)
        (else (list-walk (cdr lst) (dec step)))))

(define (is-a-cycle lst)
  (define (iter x y)
    (let ((x-walk (list-walk x 1))
          (y-walk (list-walk y 2)))
      (cond ((or (null? x-walk) (null? y-walk))
                #f)
            ((eq? x-walk y-walk)
                #t)
            (else
                (iter x-walk y-walk)))))
  (iter lst lst))

(define (last-pair x)
  (if (null? (cdr x))
      x
      (last-pair (cdr x))))

(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x)
(define x (list 'a 'b 'a))
(define z (make-cycle (list 'a 'b 'c)))

(is-a-cycle z)
(is-a-cycle x)