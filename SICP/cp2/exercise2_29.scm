#lang sicp

; 1
; (define (make-mobile left right)
;   (list left right))

; (define (make-branch length structure)
;   (list length structure))

; (define (left-branch mobile)
;   (car mobile))

; (define (right-branch mobile)
;   (car (cdr mobile)))

; (define (branch-length branch)
;   (car branch))

; (define (branch-structure branch)
;   (car (cdr branch)))

; 4 
; 修改 make-mobile 和 make-branch 定义之后
; 只需要修改 left-branch right-branch branch-length branch-structure
; 就可以保证其他方法有效
(define (make-mobile left right)
  (cons left right))

(define (make-branch length structure)
  (cons length structure))

(define (left-branch mobile)
  (car mobile))

(define (right-branch mobile)
  (cdr mobile))

(define (branch-length branch)
  (car branch))

(define (branch-structure branch)
  (cdr branch))

(define mobile (make-mobile (make-branch 10 25)
                            (make-branch 5 20)))
(left-branch mobile)  ; (10 25)
(right-branch mobile) ; (5 20)
(branch-length (left-branch mobile))  ; 10
(branch-length (right-branch mobile)) ; 5
(branch-structure (left-branch mobile))  ; 25
(branch-structure (right-branch mobile)) ; 20

; 2
(define (structure-is-mobile? structure)
  (pair? (branch-structure structure)))

(define (branch-weight branch)
  (if (structure-is-mobile? branch)
    (total-weight (branch-structure branch))
    (branch-structure branch)))

(define (total-weight mobile)
  (+ (branch-weight (left-branch mobile))
     (branch-weight (right-branch mobile))))

(define another-mobile (make-mobile (make-branch 6 mobile)
                                    (make-branch 20 40)))
(total-weight mobile)         ; 45
(total-weight another-mobile) ; 85

; 3

(define (branch-torque branch)
  (* (branch-length branch)
     (branch-weight branch)))

(define (same-torque? left right)
  (= (branch-torque left)
     (branch-torque right)))

(define (branch-blance? branch)
  (if (structure-is-mobile? branch)
      (blance? (branch-structure branch))
      #t))

(define (blance? mobile)
  (let ((left (left-branch mobile))
        (right (right-branch mobile)))
    (and (same-torque? left right)
         (branch-blance? left)
         (branch-blance? right))))

(define blance-mobile (make-mobile (make-branch 10 10)
                                   (make-branch 10 10)))

(blance? blance-mobile) ; #t

(define unblance-mobile (make-mobile (make-branch 0 1)
                                     (make-branch 10 10)))
(blance? unblance-mobile) ; #f

(define another-blance-mobile (make-mobile (make-branch 10 blance-mobile)
                                           (make-branch 10 blance-mobile)))
(blance? another-blance-mobile) ; #t

(define another-unblance-mobile (make-mobile (make-branch 0 unblance-mobile)
                                             (make-branch 10 another-blance-mobile)))
(blance? another-unblance-mobile) ; #f
