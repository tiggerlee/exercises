#lang sicp

(define (ripple-carry-adder list-A list-B list-S C)
  (define (iter A B S cin)
    (if (null? A)
        'ok
        (let ((Ak (car A))
              (Bk (car B))
              (Sk (car S))
              (remain-A (cdr A))
              (remain-B (cdr B))
              (remain-S (cdr S))
              (Ck (make-wire)))
          (set-signal! Ck cin)
          (full-adder Ak Bk Ck Sk C))))
  (iter list-A list-B list-S (get-signal C)))