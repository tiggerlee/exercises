#lang scheme
; Chapter 02 of The Little Schemer
; Do It, Do It Again, and Again, and Again...

; atom?
(define atom?
  (lambda(a)
    (and (not (pair? a)) (not (null? a)))))

; lat?
(define lat?
  (lambda (l)
    (cond
      ((null? l) #t)
      ((atom? (car l)) (lat? (cdr l)))
      (else #f))))
      
(lat? '())        ; #t
(lat? '(a b c))   ; #t
(lat? '((a) b c))  ; #f

; member?

(define member?
  (lambda (a lat)
    (cond
      ((null? lat) #f)
      ((eq? a (car lat)) #t)
      (else (member? a (cdr lat))))))
      
(member? 'a '())       ; #f
(member? 'a '(a b c))  ; #t
(member? 'a '(b c))    ; #f


