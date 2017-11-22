#lang sicp
; 将 frame 表示为下面的格式
; (frame ((var1 val1) (var2 val2) ... ))
(define (make-frame vars vals)
  (define (build-pairs vars vals)
    (if (null? vars)
        '()
        (cons
            (cons (car vars) (car vals))
            (build-pairs (cdr vars) (cdr vals)))))
  (if (= (length vars) (length vals))
      (cons 'frame (build-pairs vars vals))
      (error "MAKE FRAME length not match")))

(define (add-binding-to-frame! var val frame)
  (set-cdr! frame (cons (cons var val) (cdr frame))))

(define (frame-variables frame)
  (map car (cdr frame)))

(define (frame-values frame)
  (map cdr (cdr frame)))

(define f (make-frame (list 'a 'b 'c) (list 1 2 3)))
(display f) ; (frame ((a 1) (b 2) (c 3)))
(newline)
(add-binding-to-frame! 'd 4 f)
(display f) ; (frame ((d 4) (a 1) (b 2) (c 3)))
(newline)
(display (frame-variables f)) ; (d a b c)
(newline)
(display (frame-values f))    ; (4 1 2 3)