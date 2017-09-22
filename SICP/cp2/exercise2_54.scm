#lang sicp

; http://community.schemewiki.org/?sicp-ex-2.54 这里有更简单的写法
(define (equal? a b)
  (cond ((and (null? a) (null? b)) #t)
        ((or (null? a) (null? b)) #f)
        (else 
            (let ((cara (car a))
                  (carb (car b)))
                (cond ((and (pair? cara) (pair? carb))
                       (and (equal? cara carb) (equal? (cdr a) (cdr b))))
                       (else (if (eq? cara carb)
                                 (equal? (cdr a) (cdr b))
                                 #f)))))))

(equal? '(1 2 3 4) '(1 2 3 4))    ; #t
(equal? '() '(1 2 3 4))           ; #f
(equal? '(1 2 3) '(1 2 3 4))      ; #f
(equal? '(1 2 3) '(1 2))          ; #f
(equal? '(1 2 3) '())             ; #f
(equal? '(1 (2 3)) '(1 (2 3)))    ; #t
(equal? '(1 2 3) '(1 (2 3)))      ; #f
(equal? '(1 2 3) '(1 2 3 ()))     ; #f