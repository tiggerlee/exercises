#lang sicp

; 延迟时间
; n 个全加器的延迟时间
; 一个全加器由两个半加器和一个 or-gate 构成
; 一个半加器由两个 and-gate 和一个 inverter 一个 or-gate 构成
; n * (2 * (2 * and-gate-delay + inverter-delay + or-gate-delay) + or-gate-delay)

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