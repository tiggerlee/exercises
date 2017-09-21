#lang sicp

(define (split ti ts)
  (lambda (painter n)
    (if ( = n 0)
      painter
      (let ((smaller ((split ti ts) painter (dec n))))
        (ti painter
            (ts smaller smaller))))))

(define right-split (split beside below))
(define up-split (split below beside))
