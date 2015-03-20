#lang scheme

; atom?
(define atom?
  (lambda(a)
    (and (not (pair? a)) (not (null? a)))))

;rember-f
(define rember-f
  (lambda (test? a l)
    (cond
      ((null? l) '())
      ((test? a (car l)) (cdr l))
      (else (cons (car l)
                  (rember-f test? a (cdr l)))))))

(rember-f eq? 'a '(a b c))

;equal?
(define equal?
  (lambda (s1 s2)
    (cond
      ((and (null? s1) (null? s2)) #t)
      ((or (null? s1) (null? s2)) #f)
      ((and (atom? s1) (atom? s2)) (eq? s1 s2))
      ((or (atom? s1) (atom? s2)) #f)
      ((and (atom? (car s1)) (atom? (car s2)))
       (and (eq? (car s1) (car s2))
            (equal? (cdr s1) (cdr s2))))
      ((or (atom? (car s1)) (atom? (car s2))) #f)
      (else (and
             (equal? (car s1) (car s2))
             (equal? (cdr s1) (cdr s2)))))))

(rember-f eq? 'jelly '(jelly beans are good)) ; (beans are good)
(rember-f equal? '(pop corn) 
          '(lemonade (pop corn) and (cake)))  ; (lemonade and (cake))
(rember-f equal? '(apple) '(pear peach orage)) ; (pear peach orage)

; eq?-c
(define eq?-c
  (lambda (a)
    (lambda (x)
      (eq? x a))))

; eq?-salad
(define eq?-salad (eq?-c 'salad))

(eq?-salad 'salad)  ; #t
(eq?-salad 'salaad) ; #f

((eq?-c 'salad) 'salad) ;  #t
((eq?-c 'salad) 'tuna)  ; #f

; rewrite rember-f
(define rember-f!
  (lambda (test?)
    (lambda (a l)
      (cond
        ((null? l) '())
        ((test? a (car l)) (cdr l))
        (else (cons (car l)
                    ((rember-f! test?) a (cdr l))))))))

; rember-eq?
(define rember-eq? (rember-f! eq?))

(rember-eq? 'a '(b a c d))  ; (b c d)

((rember-f! eq?) 'a '(b a c d))  ; (b c d)
((rember-f! eq?) 'tuna '(shirmp salad and tuna salad)) ; (shirmp salad and salad)
((rember-f! eq?) 'eq? '(equal? eq? equan? eqlist? eqpair?)) ; (equal? equan? eqlist? eqpair?)

; insertL-f
(define insertL-f
  (lambda (test?)
    (lambda (new old l)
      (cond
        ((null? l) '())
        ((test? old (car l)) (cons new l))
        (else
         (cons (car l)
               ((insertL-f test?) new old (cdr l))))))))

((insertL-f eq?) 'b 'c '(a c d)) ; (a b c d)

; insertR-f
(define insertR-f
  (lambda (test?)
    (lambda (new old l)
      (cond
        ((null? l) '())
        ((test? old (car l))
         (cons old (cons new (cdr l))))
        (else
         (cons (car l)
               ((insertR-f test?) new old (cdr l))))))))

((insertR-f eq?) 'c 'b '(a b d)) ; (a b c d)

; iL   insert new to left of old in l
(define iL
  (lambda (new old l)
    (cons new (cons old l))))

(iL 'b 'c '(c d)) ; (b c d)

; iR    insert new to right of old in l
(define iR
  (lambda(new old l)
    (cons old (cons new l))))

(iR 'b 'a '(a c)) ; (a b c)

; iS subst old with new in l
(define iS
  (lambda (new old l)
    (cons new l)))

(iS 'apple 'APL '(APL banana pear))

; rewrite insertL/insertR using iR/iL
(define insertG-f
  (lambda (test? insert)
    (lambda (new old l)
      (cond
        ((null? l) '())
        ((test? old (car l))
         (insert new old (cdr l)))
        (else
         (cons
          (car l)
          ((insertG-f test? insert) new old (cdr l))))))))

((insertG-f eq? iL) 'b 'c '(a c d)) ; (a b c d)
((insertG-f eq? iR) 'c 'b '(a b d)) ; (a b c d)
((insertG-f eq? iS) 'c 'b '(a b d)) ; (a c d)

; use lambda as argument
((insertG-f equal? (lambda (new old l)
                     (cons new l)))
 'b 'c '(a c d))  ; (a b c d)

(define seqrem
  (lambda (new old l)
    l))
; same with rember
(define yyy
  (lambda (a l)
    ((insertG-f eq? seqrem) #f a l)))

(yyy 'sausage '(pizza with sausage and bacon)) ; (pizza with and bacon)

; 1st-sub-exp
(define 1st-sub-exp
  (lambda (exp)
    (car (cdr exp))))
    
; 2nd-sub-exp
(define 2nd-sub-exp
  (lambda (exp)
    (car (cdr (cdr exp)))))

; operator
(define operator
  (lambda (exp)
    (car exp)))
    

; rember value
(define value!
  (lambda (s)
    (cond
      ((atom? s) s)
      (else
       (cond
         ((eq? '+ (car s))
          (+ (value! (car (cdr s)))
             (value! (car (cdr (cdr s))))))
         ((eq? '* (car s))
          (* (value! (car (cdr s)))
             (value! (car (cdr (cdr s))))))
         ((eq? '^ (car s))
          (expt (value! (car (cdr s)))
                (value! (car (cdr (cdr s)))))))))))

; atom-to-function
(define atom-to-function
  (lambda (oper)
    (cond
      ((eq? '+ oper) +)
      ((eq? '* oper) *)
      ((eq? '^ oper) expt)
      (else #f))))

; value
(define value
  (lambda (nexp)
    (cond
      ((atom? nexp) nexp)
      (else
       ((atom-to-function
         (operator nexp))
        (value (1st-sub-exp nexp))
        (value (2nd-sub-exp nexp)))))))


(value '(+ 3 4)) ; 7
(value '(+ 3 (* 2 (^ 2 3)))) ; 19

; remember multirember
(define multirember
  (lambda (a lat)
    (cond
      ((null? lat) '())
      ((eq? a (car lat)) (multirember a (cdr lat)))
      (else (cons (car lat)
                  (multirember a (cdr lat)))))))

; multirember-f
(define multirember-f
  (lambda (test?)
    (lambda (a lat)
      (cond
        ((null? lat) '())
        ((test? a (car lat)) ((multirember-f test?) a (cdr lat)))
        (else
         (cons (car lat)
               ((multirember-f test?) a (cdr lat))))))))

((multirember-f eq?) 'a '(b a c a d)) ; (b c d)
((multirember-f equal?) '(apple) '((pear) (apple) 
                                 (banana) (apple))) ; ((pear) (banana))

; multirember-eq?
(define multirember-eq?
  (multirember-f eq?))

(multirember-eq? 'a '(b a c a d)) ; (b c d)

; eq?-tuna
(define eq?-tuna
  (eq?-c 'tuna))

; rewrite multirember-T use eq?-tuna
(define multirember-T
  (lambda (test? lat)
    (cond
      ((null? lat) '())
      ((test? (car lat)) (multirember-T test? (cdr lat)))
      (else (cons (car lat)
                  (multirember-T test? (cdr lat)))))))

(multirember-T eq?-tuna '(shrimp salad tuna salad and tuna)) ; (shrimp salad salad and)

; multirember&co
(define multirember&co
  (lambda (a lat col)
    (cond
      ((null? lat) (col '() '()))
      ((eq? (car lat) a)
       (multirember&co a
                       (cdr lat)
                       (lambda (newlat seen)
                         (col newlat
                              (cons (car lat) seen)))))
      (else
       (multirember&co a
                       (cdr lat)
                       (lambda (newlat seen)
                         (col (cons (car lat) newlat)
                              seen)))))))

; a-friend
(define a-friend
  (lambda (x y)
    (null? y)))

(multirember&co 'tuna '(strawberries tuna and swordfish) a-friend) ; #f
(multirember&co 'tuna '() a-friend) ; #t
(multirember&co 'tuna '(tuna) a-friend) ; #f

; new-friend
(define new-friend
  (lambda (newlat seen)
    (a-friend newlat
         (cons 'tuna seen))))

; last-friend
(define last-friend
  (lambda (x y)
    (length x)))

(multirember&co 'tuna '(strawberries tuna and swordfish) last-friend) ; 3

; remember multiinsertL
(define multiinsertL
  (lambda (new old lat)
    (cond
      ((null? lat) '())
      ((eq? old (car lat))
       (cons new
             (cons old
                   (multiinsertL new old (cdr lat)))))
      (else
       (cons (car lat)
             (multiinsertL new old (cdr lat)))))))

; remember multiinsertR
(define multiinsertR
  (lambda (new old lat)
    (cond
      ((null? lat) '())
      ((eq? old (car lat))
       (cons old
             (cons new 
                   (multiinsertR new old (cdr lat)))))
      (else
       (cons (car lat)
             (multiinsertR new old (cdr lat)))))))

; multiinsertLR
(define multiinsertLR
  (lambda (new oldL oldR lat)
    (cond
      ((null? lat) '())
      ((eq? oldL (car lat))
       (cons new
             (cons oldL
                   (multiinsertLR new oldL oldR (cdr lat)))))
      ((eq? oldR (car lat))
       (cons oldR 
             (cons new
                   (multiinsertLR new oldL oldR (cdr lat)))))
      (else
       (cons (car lat)
             (multiinsertLR new oldL oldR (cdr lat)))))))

(multiinsertLR 'new 'oldL 'oldR '(oldL hello oldL world)) ; (new oldL hello new oldL world)
(multiinsertLR 'new 'oldL 'oldR '(hello oldR world oldR)) ; (hello oldR new world oldR new)
(multiinsertLR 'new 'oldL 'oldR '(hello oldL world oldR)) ; (hello new oldL world oldR new)
