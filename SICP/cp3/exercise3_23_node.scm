#lang sicp

(define (make-node previous content next)
  (list previous content next))

(define (content-node node)
  (cadr node))

(define (previous-node node)
  (car node))

(define (next-node node)
  (caddr node))

(define (set-previous-node! node previous)
  (set-car! node previous))

(define (set-next-code! node next)
  (set-car! (cddr node) next))

(define (front-ptr deque)
  (car deque))

(define (rear-ptr deque)
  (cdr deque))

(define (set-front-ptr! deque item)
  (set-car! deque item))

(define (set-rear-ptr! deque item)
  (set-cdr! deque item))

(define (make-deque)
  (cons nil nil))

(define (empty-deque? deque)
  (null? (front-ptr deque)))

(define (front-deque deque)
  (content-node (front-ptr deque)))

(define (rear-deque deque)
  (content-node (rear-ptr deque)))

(define (front-insert-deque! deque item)
  (let ((new-node (make-node nil item nil)))
    (cond ((empty-deque? deque)
            (set-front-ptr! deque new-node)
            (set-rear-ptr! deque new-node)
            deque)
          (else
            (set-previous-node! (front-ptr deque) new-node)
            (set-next-code! new-node (front-ptr deque))
            (set-front-ptr! deque new-node)
            deque))))

(define (front-delete-deque! deque)
  (cond ((empty-deque? deque)
          (error "FRONT DELETE with an empty deque" deque))
        (else
          (let ((next (next-node (front-ptr deque))))
            (cond ((null? next)
                    (set-front-ptr! deque nil)
                    (set-rear-ptr! deque nil)
                    deque)
                  (else
                    (set-front-ptr! deque (next-node (front-ptr deque)))
                    (set-previous-node! (front-ptr deque) nil)
                    deque))))))

(define (rear-insert-deque! deque item)
  (let ((new-node (make-node nil item nil)))
    (cond ((empty-deque? deque)
            (set-front-ptr! deque new-node)
            (set-rear-ptr! deque new-node)
            deque)
          (else
            (set-previous-node! new-node (rear-ptr deque))
            (set-next-code! (rear-ptr deque) new-node)
            (set-rear-ptr! deque new-node)
            deque))))

(define (rear-delete-deque! deque)
  (cond ((empty-deque? deque)
          (error "REAR DELETE with an empty deque" deque))
        (else
          (let ((previous (previous-node (rear-ptr deque))))
            (cond ((null? previous)
                    (set-front-ptr! deque nil)
                    (set-rear-ptr! deque nil)
                    deque)
                  (else
                    (set-rear-ptr! deque previous)
                    (set-next-code! (rear-ptr deque) nil)
                    deque))))))

(define (print-deque deque)
  (define (get-node-contents first-node)
    (if (null? first-node)
        nil
        (cons (content-node first-node)
              (get-node-contents (next-node first-node)))))
  (display (get-node-contents (front-ptr deque)))
  (newline))

(define q (make-deque))
(empty-deque? q)            ; #t
(front-insert-deque! q 'd)
(empty-deque? q)            ; #f 
(print-deque q)             ; (d)
(rear-insert-deque! q 'e)
(print-deque q)             ; (d e)
(front-insert-deque! q 'c)
(print-deque q)             ; (c d e)
(rear-insert-deque! q 'f)
(print-deque q)             ; (c d e f)
(front-insert-deque! q 'b)
(print-deque q)             ; (b c d e f)
(front-deque q)             ; b
(rear-deque q)              ; f
(front-delete-deque! q)
(print-deque q)             ; (c d e f)
(rear-delete-deque! q)
(print-deque q)             ; (c d e)
(rear-delete-deque! q)
(print-deque q)             ; (c d)
(front-delete-deque! q)
(print-deque q)             ; (d)
(rear-delete-deque! q)
(print-deque q)             ; ()
(empty-deque? q)            ; #t
(front-insert-deque! q 1)
(print-deque q)             ; (1)
(rear-delete-deque! q)      
(print-deque q)             ; ()