#lang scheme
; Chapter 4 of The Little Schemer
; Numbers Games


; atom?
(define atom?
  (lambda(a)
    (and (not (pair? a)) (not (null? a)))))

; atom?
(atom? 14)  ; #t

; add1
(define add1
  (lambda (n)
    (+ n 1)))
    
(add1 56)  ; 57

; sub1
(define sub1
  (lambda (n)
    (- n 1)))
    
(sub1 56)        ; 55
(sub1 (add1 56))  ; 56

; zero?
(zero? 0)          ; #t
(zero? 45)         ; #f
(zero? (sub1 35))  ; #f

; my+
(define my+ 
  (lambda (m n)
    (cond
      ((zero? n) m)
      (else (add1 (my+ m (sub1 n)))))))
      
(my+ 100 24)               ; 124
(my+ (sub1 21) (add1 79))  ; 100

; my-
(define my-
  (lambda (m n)
    (cond
      ((zero? n) m)
      (else (sub1 (my- m (sub1 n)))))))
      
(my- 100 28)  ; 72

; addtup
(define addtup
  (lambda (tup)
    (cond
      ((null? tup) 0)
      (else (my+ (car tup) (addtup (cdr tup)))))))
      
(addtup '(1 2 3 4))  ; 10

; my*
(define my*
  (lambda (m n)
    (cond
      ((zero? n) 0)
      (else (my+ m (my* m (sub1 n)))))))
      
(my* 3 4)  ; 12
(my* 4 5)  ; 20

; tup+
(define tup+
  (lambda (tup1 tup2)
    (cond
      ((null? tup1) tup2)
      ((null? tup2) tup1)
      (else (cons (my+ (car tup1) (car tup2))
                  (tup+ (cdr tup1) (cdr tup2)))))))

(tup+ '(1 2 3) '(4 5 6))  ; (5 7 9)
(tup+ '(1 2 3) '(4 5 6 7))  ; (5 7 9 7)

; my>
(define my>
  (lambda (m n)
    (cond
      ((zero? m) #f)
      ((zero? n) #t)
      (else (my> (sub1 m) (sub1 n))))))

(my> 6 5)  ; #t
(my> 5 5)  ; #f
(my> 4 5)  ; #f

; my<
(define my<
  (lambda (m n)
    (cond
      ((zero? n) #f)
      ((zero? m) #t)
      (else (my< (sub1 m) (sub1 n))))))

(my< 3 4)  ; #t
(my< 4 4)  ; #f
(my< 5 4)  ; #f

; my=
(define my=
  (lambda (m n)
    (cond
      ((zero? m) (zero? n))
      ((zero? n) #f)
      (else (my= (sub1 m) (sub1 n))))))

; my=
; use my> and my<
;(define my=
;  (lambda (m n)
;    (cond
;      ((or (my> m n) (my< m n)) #f)
;      (else #t))))

(my= 2 3)  ; #f
(my= 3 2)  ; #f
(my= 2 2)  ; #t
(my= 0 0)  ; #t

; expt
(define expt
  (lambda (m n)
    (cond
      ((zero? n) 1)
      (else (my* m (expt m (sub1 n)))))))

(expt 3 2)  ; 9
(expt 2 3)  ; 8
(expt 1 1)  ; 1

; my/
; devision
(define my/
  (lambda (m n)
    (cond
      ((my< m n) 0)
      (else (add1 (my/ (my- m n) n))))))

(my/ 4 2)   ; 2
(my/ 5 2)   ; 2
(my/ 10 2)  ; 5

; length
(define length
  (lambda (lat)
    (cond
      ((null? lat) 0)
      (else (add1 (length (cdr lat)))))))

(length '())       ; 0
(length '(a b c))  ; 3
(length '(ab cd))  ; 2

; pick
(define pick
  (lambda (n lat)
    (cond
      ((zero? (sub1 n)) (car lat))
      (else (pick (sub1 n) (cdr lat))))))

(pick 1 '(a b c))  ; a
(pick 2 '(a b c))  ; b

; rempick
(define rempick
  (lambda (n lat)
    (cond
      ((zero? (sub1 n)) (cdr lat))
      (else (cons (car lat) (rempick (sub1 n) (cdr lat)))))))

(rempick 1 '(a b c))  ; (b c)
(rempick 2 '(a b c))  ; (a c)
(rempick 3 '(a b c))  ; (a b)

; no-nums
; The no-nums function returns a new lat that all numbers are removed
(define no-nums
  (lambda (lat)
    (cond
      ((null? lat) (quote ()))
      ((number? (car lat)) (no-nums (cdr lat)))
      (else (cons (car lat) (no-nums (cdr lat)))))))
      
(no-nums '(a 1 b 2 c 3))  ; (a b c)

; all-nums
; The all-nums function returns a new lat that with only numbers
(define all-nums
  (lambda (lat)
    (cond
      ((null? lat) (quote ()))
      ((number? (car lat)) (cons (car lat) (all-nums (cdr lat))))
      (else (all-nums (cdr lat))))))
      
(all-nums '(a 1 b 2 c 3 d4))  ; (1 2 3)

; eqan?
; The eqan? function determines whether two arguments are te same
; It uses eq? for atoms and = for numbers
(define eqan?
  (lambda (a1 a2)
    (cond
      ((and (number? a1) (number? a2)) (= a1 a2))
      ((or (number? a1) (number? a2)) #f)
      (else (eq? a1 a2)))))
      
(eqan? 1 1)    ; #t
(eqan? 1 2)    ; #f
(eqan? 'a 'a)  ; #t
(eqan? 'a 'b)  ; #f
(eqan? 'a 2)   ; #f

; occur
; The occur function counts the number of times an atom appears in a list
(define occur
  (lambda (a lat)
    (cond
      ((null? lat) 0)
      ((eq? a (car lat)) (add1 (occur a (cdr lat))))
      (else (occur a (cdr lat))))))
      
(occur 'a '(a b a c a d))  ; 3
(occur 'a '(b c d))        ; 0

; one?
(define one?
  (lambda (n)
    (= n 1)))
    
(one? 1)  ; #t
(one? 5)  ; #f

; rempick-one
(define rempick-one
  (lambda (n lat)
    (cond
      ((one? n) (cdr lat))
      (else
        (cons (car lat) (rempick-one (sub1 n) (cdr lat)))))))

(rempick-one 4 '(one two three four))  ; '(one two three)
