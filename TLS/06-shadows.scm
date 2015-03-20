#lang scheme

; atom?
(define atom?
  (lambda(a)
    (and (not (pair? a)) (not (null? a)))))

; numbered?
(define numbered?
  (lambda(s)
    (cond
      ((atom? s) (number? s))
      ((eq? (car (cdr s)) '+) (and
                                (numbered? (car s))
                                (numbered? (car (cdr (cdr s))))))
      ((eq? (car (cdr s)) '*) (and
                                (numbered? (car s))
                                (numbered? (car (cdr (cdr s))))))
      ((eq? (car (cdr s)) '^) (and
                                (numbered? (car s))
                                (numbered? (car (cdr (cdr s))))))
      (else #f))))

(numbered? '(3 + (4 ^ 5)))       ; #t
(numbered? '(3 + (4 ^ five)))    ; #f
(numbered? '(3 ^ (4 * (5 + 6)))) ; #t
(numbered? '(3 + 4))             ; #t

; simple numbered?
(define numbered2?
  (lambda(s)
    (cond
      ((atom? s) (number? s))
      (else (and
             (numbered2? (car s))
             (numbered2? (car (cdr (cdr s)))))))))

(numbered? '(3 + (4 ^ 5)))       ; #t
(numbered? '(3 + (4 ^ five)))    ; #f
(numbered? '(3 ^ (4 * (5 + 6)))) ; #t
(numbered? '(3 + 4))             ; #t

; value
(define value
  (lambda(s)
    (cond
      ((atom? s) s)
      ((eq? (car (cdr s)) '+)
       (+ (value (car s))
          (value (car (cdr (cdr s))))))
      ((eq? (car (cdr s)) '*)
       (* (value (car s))
          (value (car (cdr (cdr s))))))
      ((eq? (car (cdr s)) '^)
       (expt (value (car s))
             (value (car (cdr (cdr s)))))))))

(value '(2 ^ (4 * (2 + 2)))) ; 65536
(value '(2 * (4 + (2 ^ 3)))) ; 24
(value '(2 ^ 16))            ; 65536

; values
(define values
  (lambda(s)
    (cond
      ((atom? s) s)
      ((eq? (car s) '+)
       (+ (values (car (cdr s)))
          (values (car (cdr (cdr s))))))
      ((eq? (car s) '*)
       (* (values (car (cdr s)))
          (values (car (cdr (cdr s))))))
      ((eq? (car s) '^)
       (expt (values (car (cdr s)))
             (values (car (cdr (cdr s)))))))))

(values '(+ 3 4))              ; 7
(values '(^ 2 (+ 4 (* 3 4))))  ; 65536
(values '(^ 2 16))             ; 65536

; 1st_sub_exp
(define 1st_sub_exp
  (lambda(s)
    (car (cdr s))))

(1st_sub_exp '(+ 3 4))  ; 3
(1st_sub_exp '(^ 7 4))  ; 7

; 2ed_sub_exp
(define 2nd_sub_exp
  (lambda(s)
    (car (cdr (cdr s)))))

(2nd_sub_exp '(^ 3 (+ 4 5)))        ; (+ 4 5)
(2nd_sub_exp '(^ 3 (+ 4 (* 6 7))))  ; (+ 4 (* 6 7))
(2nd_sub_exp '(^ 3 4))              ; 4

; operator
(define operator
  (lambda (s)
    (car s)))

(operator '(^ 3 4))        ; ^
(operator '(* 4 (+ 2 3)))  ; *
(operator '(+ 3 4))        ; +

; rewrite values with 1st_sub_exp 2nd_sub_exp operator
(define re_values
  (lambda (s)
    (cond
      ((atom? s) s)
      ((eq? (operator s) '+)
       (+ (re_values (1st_sub_exp s))
          (re_values (2nd_sub_exp s))))
      ((eq? (operator s) '*)
       (* (re_values (1st_sub_exp s))
          (re_values (2nd_sub_exp s))))
      ((eq? (operator s) '^)
       (expt (re_values (1st_sub_exp s))
             (re_values (2nd_sub_exp s)))))))

(re_values '(+ 3 4))              ; 7
(re_values '(^ 2 (+ 4 (* 3 4))))  ; 65536
(re_values '(^ 2 16))             ; 65536

; sero?
(define sero?
  (lambda (n)
    (null? n)))

(sero? '())       ; #t
(sero? '(() ()))  ; #f
(sero? '(((())))) ; #f

; edd1
(define edd1
  (lambda (n)
    (cons '() n)))

(edd1 '())       ; (())
(edd1 '(() ()))  ; (() () ()

; zub1
(define zub1
  (lambda (n)
    (cdr n)))

(zub1 '(() ()))  ; (())
(zub1 '(()))     ; ()

; m+
(define m+
  (lambda (n m)
    (cond
      ((sero? m) n)
      (else (edd1 (m+ n (zub1 m)))))))

(m+ '(() ()) '(() ()))  ; (() () () ())
(m+ '() '(()))          ; (())
(m+ '() '())            ; ()
