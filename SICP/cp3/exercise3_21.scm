#lang sicp

(define (front-ptr queue) (car queue))
(define (rear-ptr queue) (cdr queue))
(define (set-front-ptr! queue item) (set-car! queue item))
(define (set-rear-ptr! queue item) (set-cdr! queue item))
(define (empty-queue? queue) (null? (front-ptr queue)))
(define (make-queue) (cons '() '()))
(define (front-queue queue)
  (if (empty-queue? queue)
      (error "FRONT called with an empty queue" queue)
      (car (front-ptr queue))))
(define (insert-queue! queue item)
  (let ((new-pair (cons item '())))
    (cond ((empty-queue? queue)
            (set-front-ptr! queue new-pair)
            (set-rear-ptr! queue new-pair)
            queue)
          (else 
            (set-cdr! (rear-ptr queue) new-pair)
            (set-rear-ptr! queue new-pair)
            queue))))
(define (delete-queue! queue)
  (cond ((empty-queue? queue)
          (error "DELETE! called with an empty queue" queue))
        (else
          (set-front-ptr! queue (cdr (front-ptr queue)))
          queue)))

(define (origin-display item) (display item) (newline))
(define q1 (make-queue))                ; (() ())
(origin-display (insert-queue! q1 'a))  ; ((a) b)
(origin-display (insert-queue! q1 'b))  ; ((a b) b)
(origin-display (delete-queue! q1))     ; ((b) b)
(origin-display (delete-queue! q1))     ; (() b)
; 显示这样的结果是因为实现采用的表示形式
; 例如 ((a b) b) 其中 car 部分，即 (a b) 是队列的序列，而 cdr 部分，即 (b) 为队列的队尾指针
; 所以 car 部分才是队列真正的序列，而 cdr 则是队尾指针
; 定义一个打印队列的数据项序列方法，只需要取队列的 front-ptr 部分就可以
(define (print-queue queue)
  (display (front-ptr queue))
  (newline))
(define q2 (make-queue))
(print-queue q2)                     ; ()
(print-queue (insert-queue! q2 'a))  ; (a)
(print-queue (insert-queue! q2 'b))  ; (a b)
(print-queue (delete-queue! q2))     ; (b)
(print-queue (delete-queue! q2))     ; ()