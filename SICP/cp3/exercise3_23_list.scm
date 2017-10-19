#lang sicp

(define (make-node previous node next)
  (list previous node next))

(define (previous-node node)
  (car node))

(define (content-node node)
  (cadr node))

(define (next-node node)
  (caddr node))

(define (front-ptr deque)
  (car deque))

(define (rear-ptr deque)
  (cdr deque))

(define (set-front-ptr! deque item)
  (set-car! deque item))

(define (set-rear-ptr! deque item)
  (set-cdr! deque item))

(define (make-deque)
  (cons '() '()))

(define (empty-deque? deque)
  (null? (front-ptr deque)))

(define (front-deque deque)
  (cond ((empty-deque? deque)
          (error "FRONT called with an empty deque" deque))
        (else (content-node (car (front-ptr deque))))))

(define (rear-deque deque)
  (cond ((empty-deque? deque)
          (error "REAR called with an empty deque" deque))
        (else (content-node (car (rear-ptr deque))))))

(define (front-insert-deque! deque item)
  (let ((new-node (list nil item (front-ptr deque))))
    (let ((new-pair (cons new-node nil)))
      (cond ((empty-deque? deque)
              (set-front-ptr! deque new-pair)
              (set-rear-ptr! deque new-pair)
              deque)
            (else
              (set-car! deque (cons new-node (front-ptr deque)))
              deque)))))

(define (front-delete-deque! deque)
  (cond ((empty-deque? deque)
          (error "Front delete with an empty deque" deque))
        (else
          (set-front-ptr! deque (cdr (front-ptr deque)))
          deque)))

(define (rear-insert-deque! deque item)
  (let ((new-node (make-node (rear-ptr deque) item nil)))
    (let ((new-pair (cons new-node nil)))
      (cond ((empty-deque? deque)
              (set-front-ptr! deque new-pair)
              (set-rear-ptr! deque new-pair)
              deque)
            (else
              (set-cdr! (rear-ptr deque) new-pair)
              (set-rear-ptr! deque new-pair)
              deque)))))

(define (rear-delete-deque! deque)
  (cond ((empty-deque? deque)
          (error "Rear delete with an empty deque" deque))
        (else
          (let ((previous (previous-node (rear-ptr deque))))
            (cond ((null? previous)
                     (set-front-ptr! deque nil)
                     (set-rear-ptr! deque nil)
                     deque)
                   (else
                     (set-rear-ptr! deque (cons previous nil))
                     deque))))))

(define (origin-p item)
  (display item)
  (newline))

(define (print-deque deque)
  (display
    (map (lambda (node)
            (content-node node))
         (front-ptr deque)))
  (newline))

(define q1 (make-deque))
(origin-p (front-insert-deque! q1 'c))    
(origin-p (front-insert-deque! q1 'b))
(origin-p (rear-insert-deque! q1 'd))
(origin-p (front-insert-deque! q1 'a))
(origin-p (rear-insert-deque! q1 'e))