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

(define (make-serializer)
  (let ((mutex (make-mutex)))
    (lambda (p)
      (define (serializer-p . args)
        (mutex 'acquire)
        (let ((val (apply p args)))
          (mutex 'release)
          val))
      serializer-p)))

(define id 0)

(define (generate-id)
  (begin (set! id (+ id 1))
         id))

(define (make-account balance)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (begin (set! balance (+ balance amount))
           balance))
  (let ((balance-serializer (make-serializer))
        (account-id (generate-id)))
    (define (dispatch m)
      (cond ((eq? m 'withdraw) withdraw)
            ((eq? m 'deposit) deposit)
            ((eq? m 'balance) balance)
            ((eq? m 'serializer) balance-serializer)
            ((eq? m 'id) account-id)
            (else (error "Unknown request -- MAKE-ACCOUNT" m))))
    dispatch))

(define (exchange account1 account2)
  (let ((difference (- (account1 'balance)
                       (account2 'balance))))
    ((account1 'withdraw) difference)
    ((account2 'deposit) difference)))

(define (serializer-exchange account1 account2)
  (let ((account1-id (account1 'id))
        (account2-id (account2 'id)))
    (if (> account1-id account2-id)
        (((account2 'serializer) ((account1 'serializer) exchange)) account1 account2)
        (((account1 'serializer) ((account2 'serializer) exchange)) account1 account2))))

; 发生死锁是因为获取串行化顺序发生了竞争，第一个交换请求先获取了账号 a1 的串行化集合
; 此时第二个交换请求获取了 a2 的串行化集合，并且尝试获取 a1 的串行化集合
; 而与此同时，第一个交换请求也试图获取 a2 的串行化集合
; 获取了 a1 的过程在等待 获取了 a2 的过程释放资源，而 获取了 a2 的过程在等待 a1 释放，从而产生了死锁。
; 所以解决死锁就是解决获取的顺序，根据账号 id 获取，获取顺序是一致的，一个过程开始执行，获取了账号 id 最小的串行化集合对象
; 此时如果有其他过程开始执行，同样会试图获取账号 id 最小的，但此时此账号已被第一个过程占用，所以其他过程都需要等待第一个过程执行完毕释放资源才可以执行
; 从而避免了竞争，解决了死锁问题
(define a1 (make-account 100))
(define a2 (make-account 200))
(serializer-exchange a1 a2)
(serializer-exchange a2 a1)
(a1 'balance)
(a2 'balance)