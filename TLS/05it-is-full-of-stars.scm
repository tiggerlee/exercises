#lang scheme

; atom?
(define atom?
  (lambda(a)
    (and (not (pair? a)) (not (null? a)))))

; rember*
(define rember*
  (lambda(a l)
    (cond
      ((null? l) '())
      ((atom? (car l))
       (cond
         ((eq? a (car l)) (rember* a (cdr l)))
         (else (cons (car l)
                     (rember* a (cdr l))))))
      (else (cons
             (rember* a (car l))
             (rember* a (cdr l)))))))

(rember* 'cup '((coffee) cup ((tea) cup) (and (hick)) cup)) ; ((coffee) ((tea)) (and (hick)))
(rember* 'sauce '(((tomato sauce)) ((bean) sauce) (and ((flying)) sauce))) ; (((tomato)) ((bean)) (and ((flying))))

;insertR*
(define insertR*
  (lambda(new old l)
    (cond
      ((null? l) '())
      ((atom? (car l))
       (cond
         ((eq? old (car l)) (cons old
                                  (cons new
                                        (insertR* new old (cdr l)))))
         (else (cons (car l)
                     (insertR* new old (cdr l))))))
      (else (cons (insertR* new old (car l))
                  (insertR* new old (cdr l)))))))

(insertR* 'roast 'chuck '((how much (wood))        ; ((how much (wood)
                          could                    ; could
                          ((a (wood) chuck))       ; ((a (wood) chuck roast))
                          (((chuck)))              ; (((chuck roast)))
                          (if (a) ((wood chuck)))  ; (if (a) ((wood chuck roast)))
                          could chuck wood))       ; could chuck roast wood)

; occur*
(define occur*
  (lambda(a l)
    (cond
      ((null? l) 0)
      ((atom? (car l))
       (cond
         ((eq? a (car l)) (add1(occur* a (cdr l))))
         (else (occur* a (cdr l)))))
      (else (+ (occur* a (car l))
             (occur* a (cdr l)))))))

(occur* 'banana '((banana)
                  (split ((((banana ice)))
                          (cream (banana))
                          sherbet))
                  (banana)
                  (bread)
                  (banana brandy)))          ; 5

; subst*
(define subst*
  (lambda(new old l)
    (cond
      ((null? l) '())
      ((atom? (car l))
       (cond
         ((eq? old (car l)) (cons new 
                                  (subst* new old (cdr l))))
         (else (cons (car l)
                     (subst* new old (cdr l))))))
      (else (cons (subst* new old (car l))
                  (subst* new old (cdr l)))))))

(subst* 'orange 'banana '((banana)           ; ((orange)
                  (split ((((banana ice)))   ; (split ((((orange ice)))
                          (cream (banana))   ; (cream (orange))
                          sherbet))          ; sherbet))
                  (banana)                   ; (orange)
                  (bread)                    ; (bread)
                  (banana brandy)))          ; (orange brandy))

; insertL*
(define insertL*
  (lambda(new old l)
    (cond
      ((null? l) '())
      ((atom? (car l))
       (cond
         ((eq? old (car l)) (cons new 
                                  (cons old
                                        (insertL* new old (cdr l)))))
         (else (cons (car l)
                     (insertL* new old (cdr l))))))
      (else (cons (insertL* new old (car l))
                  (insertL* new old (cdr l)))))))

(insertL* 'pecker 'chuck '((how much (wood))        ; ((how much (wood)
                          could                    ; could
                          ((a (wood) chuck))       ; ((a (wood) pecker chuck))
                          (((chuck)))              ; (((pecker chuck)))
                          (if (a) ((wood chuck)))  ; (if (a) ((wood pecker chuck)))
                          could chuck wood))       ; could pecker chuck wood)

; member*
(define member*
  (lambda(a l)
    (cond
      ((null? l) #f)
      ((atom? (car l))
       (cond
         ((eq? a (car l)) #t)
         (else (member* a (cdr l)))))
      (else (or (member* a (car l))
                (member* a (cdr l)))))))

(member* 'chips '((potato) (chips ((with) fish) (chips)))) ; #t

; leftmost
(define leftmost
  (lambda(l)
    (cond
      ((null? l) '())
      ((atom? (car l)) (car l))
      (else (leftmost (car l))))))

(leftmost '((potato) (chips ((with) fish) (chips))))  ; potato
(leftmost '(((hot) (tuna (and))) cheese))             ; hot
(leftmost '())                                        ; ()
(leftmost '(((() four)) 17 (seventeen)))              ; ()

; eqlist?
(define eqlist?
  (lambda(s1 s2)
    (cond
      ((and (null? s1) (null? s2)) #t)
      ((or (null? s1) (null? s2)) #f)
      ((and (atom? (car s1)) (atom? (car s2))) (and (eq? (car s1) (car s2))
                                                    (eqlist? (cdr s1) (cdr s2))))
      ((or (atom? (car s1)) (atom? (car s2))) #f)
      (else (and (eqlist? (car s1) (car s2))
                 (eqlist? (cdr s1) (cdr s2)))))))

(eqlist? '(strawberry ice cream) '(strawberry ice cream))
(eqlist? '(banana ((split))) '((banana) (split)))
(eqlist? '(beef ((sausage)) (and (soda))) '(beef ((salami)) (and (soda))))
(eqlist? '(beef ((sausage)) (and (soda))) '(beef ((sausage)) (and (soda))))

; equal?
(define equal?
  (lambda(s1 s2)
    (cond
      ((and (atom? s1) (atom? s2)) (eq? s1 s2))
      ((or (atom? s1) (atom? s2)) #f)
      (else (eqlist? s1 s2)))))

(equal? 'a 'a)
(equal? '(strawberry ice cream) '(strawberry ice cream))
(equal? '(banana ((split))) '((banana) (split)))
(equal? '(beef ((sausage)) (and (soda))) '(beef ((salami)) (and (soda))))
(equal? '(beef ((sausage)) (and (soda))) '(beef ((sausage)) (and (soda))))

; rewrite eqlist? using equal?
(define eqlist2?
  (lambda(l1 l2)
    (cond
      ((and (null? l1) (null? l2)) #t)
      ((or (null? l1) (null? l2)) #f)
      (else (and (equal? (car l1) (car l2))
                 (eqlist? (cdr l1) (cdr l2)))))))

(eqlist2? '(a b c) '(a b c d)) ; #f
(eqlist2? '(strawberry ice cream) '(strawberry ice cream)) ; #t
(eqlist2? '(banana ((split))) '((banana) (split))) ; #f
(eqlist2? '(beef ((sausage)) (and (soda))) '(beef ((salami)) (and (soda)))) ; #f
(eqlist2? '(beef ((sausage)) (and (soda))) '(beef ((sausage)) (and (soda)))) ; #t

; rewrite rember
(define rember2
  (lambda(s l)
    (cond
      ((null? l) '())
      ((equal? (car l) s) (cdr l))
      (else (cons (car l)
                  (rember2 s (cdr l)))))))

(rember2 '(a) '((a) (a) b c)) ; ((a) b c)

; rember*
(define rember2*
  (lambda(s l)
    (cond
      ((null? l) '())
      ((equal? (car l) s) (rember2* s (cdr l)))
      (else (cons (car l)
                  (rember2* s (cdr l)))))))

(rember2* '(a) '((a) (a) b c)) ; (b c)
(rember2* '(a) '(((a) (a)) (a) b)) ; (((a) (a)) b)

; rember**
(define rember**
  (lambda(s l)
    (cond
      ((null? l) '())
      ((atom? (car l))
       (cond
         ((equal? s (car l)) (rember** s (cdr l)))
         (else (cons (car l)
                     (rember** s (cdr l))))))
      (else 
       (cond
         ((equal? s (car l)) (rember** s (cdr l)))
         (else (cons (rember** s (car l))
                     (rember** s (cdr l)))))))))

(rember** '(a) '(((a) b (a)) (a) b)) ; ((b) b)