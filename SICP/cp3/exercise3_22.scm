#lang sicp

(define (make-queue)
  (let ((front-ptr nil)
        (rear-ptr nil))
    (define (empty-queue?) (null? front-ptr))
    (define (front-queue)
      (if (empty-queue?)
          (error "FRONT called with an empty queue")
          (car front-ptr)))
    (define (insert-queue! item)
      (let ((new-pair (cons item nil)))
        (cond ((empty-queue?)
                (set! front-ptr new-pair)
                (set! rear-ptr new-pair)
                front-ptr)
              (else
                (set-cdr! rear-ptr new-pair)
                (set! rear-ptr new-pair)
                front-ptr))))
    (define (delete-queue!)
      (cond ((empty-queue?)
              (error "DELETE! called with an empty queue"))
            (else
              (set! front-ptr (cdr front-ptr))
              front-ptr)))
    
    (define (dispatch m)
      (cond ((eq? m 'empty-queue?) (empty-queue?))
            ((eq? m 'front-queue) (front-queue))
            ((eq? m 'insert-queue!) insert-queue!)
            ((eq? m 'delete-queue!) (delete-queue!))
            (else
              (error "No such a method: " m))))
    dispatch))

(define q1 (make-queue))
(q1 'empty-queue?)        ; #t
((q1 'insert-queue!) 'a)  ; (a)
(q1 'empty-queue?)        ; #f
(q1 'front-queue)         ; a
((q1 'insert-queue!) 'b)  ; (a b)
(q1 'empty-queue?)        ; #f
(q1 'front-queue)         ; a
(q1 'delete-queue!)       ; (b)
(q1 'empty-queue?)        ; #f
(q1 'front-queue)         ; b
((q1 'insert-queue!) 'c)  ; (b c)
(q1 'empty-queue?)        ; #f
(q1 'front-queue)         ; b
(q1 'delete-queue!)       ; (c)
(q1 'delete-queue!)       ; ()
(q1 'empty-queue?)        ; #t