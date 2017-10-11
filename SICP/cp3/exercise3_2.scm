#lang sicp

(define (make-monitored f)
  (let ((counter 0))
    (lambda (exp)
      (cond ((eq? exp 'how-many-calls?) counter)
            ((eq? exp 'reset-count)
             (begin (set! counter 0) counter))
            (else (begin (set! counter (inc counter))
                         (f exp)))))))

(define s (make-monitored sqrt))
(s 100)              ; 10
(s 'how-many-calls?) ; 1
(s 'reset-count)
(s 'how-many-calls?)
