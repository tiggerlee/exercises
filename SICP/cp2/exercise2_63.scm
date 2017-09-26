#lang sicp

(define (entry tree) (car tree))

(define (left-branch tree) (cadr tree))

(define (right-branch tree) (caddr tree))

(define (make-tree entry left right)
  (list entry left right))

(define (element-of-set? x set)
  (cond ((null? set) #f)
        ((= x (entry set)) #t)
        ((< x (entry set))
         (element-of-set? x (left-branch set)))
        ((> x (entry set))
         (element-of-set? x (right-branch set)))))

(define (adjoin-set x set)
  (cond ((null? set) (make-tree x '() '()))
        ((= x (entry set)) set)
        ((< x (entry set))
         (make-tree (entry set)
                    (adjoin-set x (left-branch set))
                    (right-branch set)))
        ((> x (entry set))
         (make-tree (entry set)
                    (left-branch set)
                    (adjoin-set x (right-branch set))))))

(define (tree->list-1 tree)
  (if (null? tree)
      '()
      (append (tree->list-1 (left-branch tree))
              (cons (entry tree)
                    (tree->list-1 (right-branch tree))))))

;(append (txx (3 1 5) (cons 7 (9 nil 11))))
;(append (append (txx (1 nil nil) (cons 3 (txx (5 nil nil))))) ...

(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list (right-branch tree)
                                          result-list)))))
  (copy-to-list tree '()))

;(copy (7 (3 1 5) (9 nil 11)) '())
;(copy (3 1 5) (cons 7 (copy (9 nil 11) '())))

(define tree-7 (adjoin-set 11 (adjoin-set 5 (adjoin-set 1 (adjoin-set 9 (adjoin-set 3 (adjoin-set 7 nil)))))))
(display tree-7)
(newline)
(define tree-3 (adjoin-set 11 (adjoin-set 9 (adjoin-set 5 (adjoin-set 7 (adjoin-set 1 (adjoin-set 3 nil)))))))
(display tree-3)
(define tree-5 (adjoin-set 11 (adjoin-set 7 (adjoin-set 1 (adjoin-set 9 (adjoin-set 3 (adjoin-set 5 nil)))))))
(newline)
(display tree-5)
(newline)
(display (tree->list-1 tree-7))
(newline)
(display (tree->list-2 tree-7))
(newline)
(display (tree->list-1 tree-3))
(newline)
(display (tree->list-2 tree-3))
(newline)
(display (tree->list-1 tree-5))
(newline)
(display (tree->list-2 tree-5))