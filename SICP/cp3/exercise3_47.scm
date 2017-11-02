#lang sicp

(define (make-mutex)
  (let ((cell (list false)))
    (define (the-mutex m)
      (cond ((eq? m 'acquire)
              (if (test-and-set! cell)
                  (the-mutex 'acquire)))
            ((eq? m 'release) (clear! cell))))
    the-mutex))

(define (clear! cell)
  (set-car! cell false))

(define (test-and-set! cell)
  (if (car cell)
      true
      (begin (set-car! cell true)
             false)))

(define (make-semaphore n)
  (let ((the-mutex (make-mutex)))
    (define (acquire)
      (the-mutex 'acquire)
      (if (> n 0)
          (begin (set! n (- n 1))
                 (the-mutex 'release)
                 'ok)
          (begin (the-mutex 'release)
                 (acquire))))
    (define (release)
      (the-mutex 'acquire)
      (set! n (+ n 1))
      (the-mutex 'release)
      'ok)
    (define (dispatch m)
      (cond ((eq? m 'acquire) (acquire))
            ((eq? m 'release) (release))))
    dispatch))

(define (make-semaphore-atom n)
  (define (acquire)
    (if (test-and-set!)
        'ok
        (acquire)))

  (define (release)
    (set! n (+ n 1))
    'ok)

  (define (dispatch m)
    (cond ((eq? m 'acquire) (acquire))
          ((eq? m 'release) (release))))
  (define (test-and-set!)
    (if (> n 0)
        (begin (set! n (- n 1))
               true)
        false))
  dispatch)

(define s (make-semaphore 3))
(s 'acquire)
(s 'acquire)
(s 'acquire)
(s 'release)
(s 'acquire)

(define ss (make-semaphore-atom 3))
(ss 'acquire)
(ss 'acquire)
(ss 'acquire)
(ss 'release)
(ss 'acquire)