#lang scheme
; Chapter 1 of The Little Schemer

; atom?
(define atom?
  (lambda(a)
    (and (not (pair? a)) (not (null? a)))))


; Atoms
'atom
(quote atom)
'1942
'turkey
'u
'*abc$

;Lists and S-expressions
'(atom)
'(atom turkey or)
'((atom turkey) or)
'xyz
'(x y z)
'((x y) z)
'(how are you doing so far)
'(((how) are) ((you) (doing so)) far)
'()
'(() () ())

; car
(car '(a b c))  ; a
(car '((a b c) x y z))  ; (a b c)
;(car 'hotdog)  ; cannot ask for the car of an atom
;(car '())      ; cannot ask for the car of the empty list
(car '(((hotdogs)) (and) (pickle) relish))  ; ((hotdogs))
(car (car '(((hotdogs)) (and))))  ; (hotdogs)

;cdr
(cdr '((a b c) x y z))  ; (x y z)
(cdr '(hamburger))  ; ()
(cdr '((x) t r))  ; (t r)
;(cdr 'hotdogs)  ; cannot ask for the cdr of an atom
;(cdr '())       ; cannot ask for the cdr of the null list

; car and cdr
(car (cdr '((b) (x y) ((c)))))  ; (x y)
(cdr (cdr '((b) (x y) ((c)))))  ; (((c)))
;(cdr (car '(a (b (c)) d)))     ; since (car '(a (b (c)) d)) is an atom, and cdr does not take an atom as argument

;cons
(cons 'peanut '(butter and jelly))  ; (peanut butter and jelly)
(cons '(banana and) '(peanut butter and jelly))  ; ((banana and) peanut butter and jelly)
(cons '((help) this) '(is very ((hard) to learn)))  ; (((help) this) is very ((hard) to learn))
(cons '(a b (c)) '())  ; ((a b (c)))
(cons 'a '())  ; (a)
;(cons '((a b c)) 'b)  ; the second argument must be a list
;(cons 'a 'b)          ; the second argument must be a list too
(cons 'a (car '((b) c d)))  ; (a b)  ;because (car '((b) c d)) is '(b) and (cons 'a '(b)) is '(a b)
(cons 'a (cdr '((b) c d)))  ; (a c d)  ;because (cdr '((b) c d)) is '(c d) and (cons 'a '(c d)) is '(a c d)

;null?
(null? (quote ()))  ; true #t
(null? '(a b c))    ; false #f
;(null? 'spaghetti)  ;cannot ask null? of an atom

;atom?
(atom? 'Harry)  ; true #t
(atom? '(Harry had a heap of apples))  ; false #f
(atom? (car '(Harry had a heap of apples)))  ; true #t
(atom? (cdr '(Harry had a heap of apples)))  ; false #f
(atom? (cdr '(Harry)))  ; false #f
(atom? (car (cdr '(swing low sweet cherry oat))))  ; true #t
(atom? (car (cdr '(swing (low sweet) cherry oat))))  ; false #f

;eq?
(eq? 'Harry 'Harry)  ; true #t
(eq? 'margarine 'butter)  ; false #f
;(eq? '() '(strawberry))  ;cannot ask eq? for lists
;(eq? '6 '7)  ; cannot ask eq? for numeric atom
(eq? (car '(Mary had a little lamb chop)) 'Mary)  ; true #t
(eq? (car '(beans beans we need jelly benas)) (car (cdr '(beans beans we need jelly beans))))  ; true #t
;(eq? (cdr '(soured milk)) 'milk)  ; because (cdr '(soured milk)) is '(milk) and this is a list






