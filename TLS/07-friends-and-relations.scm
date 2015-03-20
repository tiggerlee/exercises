#lang scheme

; atom?
(define atom?
  (lambda(a)
    (and (not (pair? a)) (not (null? a)))))

; member?
(define member?
  (lambda (a lat)
    (cond
      ((null? lat) #f)
      ((eq? (car lat) a) #t)
      (else (member? a (cdr lat))))))

; set?
(define set?
  (lambda (lat)
    (cond
      ((null? lat) #t)
      ((member? (car lat) (cdr lat)) #f)
      (else (set? (cdr lat))))))

(set? '(apple peaches apple plum))  ; #f
(set? '(apples peaches pears plums))  ; #t
(set? '())  ; #t

; makeset
(define makeset
  (lambda (lat)
    (cond
      ((null? lat) '())
      ((member? (car lat) (cdr lat)) (makeset (cdr lat)))
      (else (cons
             (car lat)
             (makeset (cdr lat)))))))

(makeset '(apple peach pear 
                 peach plum apple 
                 lemon peach))  ; (pear plum apple lemon peach)

; multirember
(define multirember
  (lambda (a lat)
    (cond
      ((null? lat) '())
      ((eq? a (car lat)) (multirember a (cdr lat)))
      (else (cons (car lat)
                  (multirember a (cdr lat)))))))

; rewrite makeset using multirember
(define makeset!
  (lambda (lat)
    (cond
      ((null? lat) '())
      (else (cons
             (car lat)
             (makeset! (multirember (car lat) (cdr lat))))))))

(makeset! '(apple peach pear 
                  peach plum apple 
                  lemon peach))  ; (apple peach pear plum lemon)
(makeset! '(apple 3 peach 3 
                  pear 4 peach 9 
                  plum apple lemon 
                  peach))  ; (apple 3 peach pear 4 9 plum lemon)

; subset?
(define subset?
  (lambda (set1 set2)
    (cond
      ((null? set1) #t)
      ((member? (car set1) set2) (subset? (cdr set1) set2))
      (else #f))))

(subset? '(5 chicken wings) 
         '(5 hamburgers 2 
             pieces fried chicken 
             and light duckling 
             wings))              ; #t

(subset? '(4 pounds of horseradish)
         '(four pounds chicken and
                5 ounces horseradish))  ; #f

; eqset?
(define eqset?
  (lambda (s1 s2)
    (and (subset? s1 s2)
         (subset? s2 s1))))

(eqset? '(a b c) '(b c a))   ; #t
(eqset? '(a b c d) '(d c a)) ; #f

; intersect?
(define intersect?
  (lambda (s1 s2)
    (cond
      ((null? s1) #f)
      ((member? (car s1) s2) #t)
      (else (intersect? (cdr s1) s2)))))

(intersect? '(stewed tomatoes and macaroni)
            '(macaroni and cheese))         ; #t

; rewrite intersect? using or
(define intersect?!
  (lambda (s1 s2)
    (cond
      ((null? s1) #f)
      (else
       (or (member? (car s1) s2)
           (intersect?! (cdr s1) s2))))))

(intersect?! '(stewed tomatoes and macaroni)
            '(macaroni and cheese))         ; #t

; intersect
(define intersect
  (lambda (s1 s2)
    (cond
      ((null? s1) '())
      ((member? (car s1) s2) (cons (car s1)
                                   (intersect (cdr s1) s2)))
      (else (intersect (cdr s1) s2)))))

(intersect '(stewed tomatoes and macaroni)
            '(macaroni and cheese))         ; (and macaroni)

; union
(define union
  (lambda (s1 s2)
    (cond
      ((null? s1) s2)
      ((member? (car s1) s2) (union (cdr s1) s2))
      (else (cons (car s1)
                  (union (cdr s1) s2))))))

(union '(stewed tomatoes and
                macaroni casserole)
       '(macaroni and cheese))      ; (stewed tomatoes casserole macaroni and cheese)


; diff difference (set) function
(define diff
  (lambda(s1 s2)
    (cond
      ((null? s1) '())
      ((member? (car s1) s2) (diff (cdr s1) s2))
      (else (cons (car s1)
                  (diff (cdr s1) s2))))))

(diff '(stewed tomatoes and
                macaroni casserole)
       '(macaroni and cheese))      ; (stewed tomatoes casserole)
       
; intersectall
(define intersectall
  (lambda (l-set)
    (cond
      ((null? (cdr l-set)) (car l-set))
      (else (intersect (car l-set)
                       (intersectall (cdr l-set)))))))

(intersectall '((a b c) (c a d e) (e f g h a b)))  ; (a)
(intersectall '((6 pears and)
                (3 peaches and 6 plums)
                (8 pears and 6 plums)
                (and 6 prunes with some apples)))  ; (6 and)

; a-pair?
(define a-pair?
  (lambda (x)
    (cond
      ((null? x) #f)
      ((atom? x) #f)
      ((null? (cdr x)) #f)
      ((null? (cdr (cdr x))) #t)
      (else #f))))

(a-pair? '())                      ; #f
(a-pair? '(3 7))                   ; #t
(a-pair? '((2) (pair)))            ; #t
(a-pair? '(full (house)))          ; #t
(a-pair? '(pair))                  ; #f
(a-pair? '((pair) (pair) (pair)))  ; #f

; first of a pair
(define first
  (lambda (p)
    (car p)))

(first '(first second))      ; first
(first '((first) (second)))  ; (first)

; second of a pair
(define second
  (lambda (p)
    (car (cdr p))))

(second '(first second))      ; second
(second '((first) (second)))  ; (second)

; build a pair
(define build
  (lambda (s1 s2)
    (cons s1 (cons s2 '()))))

(build '(apple) '((pear)))    ; ((apple) ((pear)))
(build 'apple 'pear)          ; (apple pear)

; firsts
(define firsts
  (lambda (s)
    (cond
      ((null? s) '())
      (else (cons (car (car s))
                  (firsts (cdr s)))))))

(firsts '((2 3) (3 4) (4 5)))  ; (2 3 4)
(firsts '())                   ; ()

; fun?
(define fun?
  (lambda (rel)
    (set? (firsts rel))))

(fun? '((4 3) (4 2) (7 6) (6 2) (3 4)))  ; #f
(fun? '((8 3) (4 2) (7 6) (6 2) (3 4)))  ; #t
(fun? '((d 4) (b 0) (b 9) (e 5) (g 4)))  ; #f

; revrel
(define revrel
  (lambda (rel)
    (cond
      ((null? rel) '())
      (else (cons (build (second (car rel))
                         (first (car rel)))
                  (revrel (cdr rel)))))))

(revrel '((a 8) (pumpkin pie) (got sick)))  ; ((8 a) (pie pumpkin) (sick got))

; revpair
(define revpair
  (lambda (pair)
    (build (second pair) (first pair))))

(revpair '(apple pear))     ; (pear apple)
(revpair '((apple) (pear))) ; ((pear) (apple))

;rewrite revrel using revpair
(define revrel!
  (lambda (rel)
    (cond
      ((null? rel) '())
      (else (cons (revpair (car rel))
                  (revrel (cdr rel)))))))

(revrel! '((a 8) (pumpkin pie) (got sick)))  ; ((8 a) (pie pumpkin) (sick got))

; seconds
(define seconds
  (lambda (rel)
    (cond
      ((null? rel) '())
      (else (cons (car (cdr (car rel)))
                  (seconds (cdr rel)))))))

(seconds '((apple pear) (banana orange)))  ; (pear orange)

; fullfun?
(define fullfun?
  (lambda (rel)
    (set? (seconds rel))))

(fullfun? '((8 3) (4 8) (7 6) (6 2) (3 4))) ; #t
(fullfun? '((grape raisin)
            (plum prune)
            (stewed prune)))  ; #f
(fullfun? '((grape raisin)
            (plum prune)
            (stewed grape)))  ; #t

; one-to-one?
(define one-to-one?
  (lambda (rel)
    (fun? (revrel rel))))

(one-to-one? '((8 3) (4 8) (7 6) (8 2) (3 4))) ; #t
(one-to-one? '((grape raisin)
            (plum prune)
            (stewed prune)))  ; #f
