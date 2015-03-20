#lang scheme
; Chapter 3 of The Little Schemer
; Cons the Magnificent

; atom?
(define atom?
  (lambda(a)
    (and (not (pair? a)) (not (null? a)))))

; rember
(define rember
  (lambda(a l)
    (cond
      ((null? l) '())
      ((eq? (car l) a) (cdr l))
      (else (cons (car l)
                  (rember a (cdr l)))))))
      
(rember 'bacon '(bacon lettuce and tomato))  ; (lettuce and tomato)
(rember 'and '(bacon lettuce and tomato))    ; (bacon lettuce tomato)

; firsts
(define firsts
  (lambda(l)
    (cond
      ((null? l) '())
      (else (cons (car (car l))
                  (firsts (cdr l)))))))
      
(firsts '((a b) (c d) (e f)))                                      ; (a c e)
(firsts '(((five plums) four) (eleven green orages) ((no) more)))  ; ((five plums) eleven (no))

; insertR
(define insertR
  (lambda(new old lat)
    (cond
      ((null? lat) '())
      ((eq? (car lat) old) (cons old
                             (cons new 
                                  (cdr lat))))
      (else (cons (car lat) 
                  (insertR new old (cdr lat)))))))

(insertR 'e 'd '(a b c d f g))                                 ; (a b c d e f g)
(insertR 'topping 'fudge '(ice cream with fudge for dessert))  ; (ice cream with fudge topping for dessert)

; insertL
(define insertL
  (lambda(new old lat)
    (cond
      ((null? lat) '())
      ((eq? old (car lat)) (cons new lat))
      (else (cons (car lat) 
                  (insertL new old (cdr lat)))))))

(insertL 'd 'e '(a b c e f))  ; (a b c d e f)

; subst
(define subst
  (lambda(new old lat)
    (cond
      ((null? lat) '())
      ((eq? old (car lat)) (cons new 
                                 (cdr lat)))
      (else (cons (car lat)
                  (subst new old (cdr lat)))))))

(subst 'a 'A '(A b c))                       ; (a b c)
(subst 'banana 'apple '(apple orange pear))  ; (banana orange pear)

; subst2
(define subst2
  (lambda(new o1 o2 lat)
    (cond
      ((null? lat) '())
      ((or (eq? o1 (car lat))
           (eq? o2 (car lat)))
         (cons new 
             (cdr lat)))
      (else (cons (car lat)
                  (subst2 new o1 o2 (cdr lat)))))))

(subst2 'apple 'ap 'apl '(ap apl pear))         ; (apple apl pear)
(subst2 'apple 'apl 'ap '(banana apl ap pear))  ; (banana apple ap pear)

; multirember
(define multirember
  (lambda(a lat)
    (cond
      ((null? lat) '())
      ((eq? a (car lat)) (multirember a (cdr lat)))
      (else (cons (car lat)
                  (multirember a (cdr lat)))))))
      
(multirember 'cup '(coffee cup tea cup and hick cup))  ; (coffee tea and hick)

; multiinsertR
(define multiinsertR
  (lambda(new old lat)
    (cond
      ((null? lat) '())
      ((eq? old (car lat)) (cons old
                                 (cons new 
                                       (multiinsertR new old (cdr lat)))))
      (else (cons (car lat)
                  (multiinsertR new old (cdr lat)))))))
      
(multiinsertR 'good 'very '(tea is very and food is very))  ; (tea is very good and food is very good)
(multiinsertR 'b 'a '(a c a c a c))                         ; (a b c a b c a b c)

;multiinsertL
(define multiinsertL
  (lambda(new old lat)
    (cond
      ((null? lat) '())
      ((eq? old (car lat)) (cons new 
                                 (cons old
                                       (multiinsertL new old (cdr lat)))))
      (else (cons (car lat)
                  (multiinsertL new old (cdr lat)))))))
      
(multiinsertL 'very 'good '(tea is good and food is good))  ; (tea is very good and food is very good)
(multiinsertL 'b 'c '(a c a c a c))                         ; (a b c a b c a b c)

; multisubst
(define multisubst
  (lambda(new old lat)
    (cond
      ((null? lat) '())
      ((eq? old (car lat)) (cons new
                                 (multisubst new old (cdr lat))))
      (else (cons (car lat)
                  (multisubst new old (cdr lat)))))))
      
(multisubst 'banana 'apple '(apple is good and I like apple))         ; (banana is good and I like banana)
(multisubst 'Apl 'apple '(apple is apple and apple isn't bad apple))  ; (Apl is Apl and Apl isn 't bad Apl)
