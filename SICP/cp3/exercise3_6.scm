#lang sicp

(define random-init 0)
(define (rand-update x) (+ x 1))

(define rand
  (let ((x random-init))
    (define (dispatch command)
      (cond ((eq? command 'generate)
             (begin (set! x (rand-update x))
                    x))
            ((eq? command 'reset)
             (lambda (new-value)
               (begin (set! x new-value)
                      x)))
            (else
             (error "No sunch method " command))))
    dispatch))

(rand 'generate)  ; 1
(rand 'generate)  ; 2
((rand 'reset) 0) ; 0
(rand 'generate)  ; 1