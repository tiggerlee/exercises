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

(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list (right-branch tree)
                                          result-list)))))
  (copy-to-list tree '()))

(define (partial-tree elts n)
  (if (= n 0)
      (cons '() elts)
      (let ((left-size (quotient (- n 1) 2)))
        (let ((left-result (partial-tree elts left-size)))
          (let ((left-tree (car left-result))
                (non-left-elts (cdr left-result))
                (right-size (- n (+ left-size 1))))
            (let ((this-entry (car non-left-elts))
                  (right-result (partial-tree (cdr non-left-elts)
                                              right-size)))
              (let ((right-tree (car right-result))
                    (remaining-elts (cdr right-result)))
                (cons (make-tree this-entry left-tree right-tree)
                      remaining-elts))))))))

(define (list->tree elements)
  (car (partial-tree elements (length elements))))

(display (list->tree (list 1 3 5 7 9 11)))
; a
; 使用替换法分析 partial-tree
; (list->tree (1 3 5 7 9 11))
; (partial-tree (1 3 5 7 9 11) 6)
; (cons (make-tree (car (cdr (partial-tree (1 3 5 7 9 11) 2))) ; 这里计算出 entry
;                  (car (partial-tree (1 3 5 7 9 11) 2))       ; 计算出左子树
;                  (car (partial-tree (cdr (cdr (partial-tree (1 3 5 7 9 11) 2))) 3))) ;计算右子树
;       (cdr (partial-tree (cdr (cdr (partial-tree (1 3 5 7 9 11) 2))) 3)))
; 从上面可以看出，partial-tree 将生成树的列表分为三部分 entry 左子树 右子树 并递归的对左右子树继续调用 partial-tree这个过程
; 从而生成平衡的二叉树
;        5
;       / \
;      1   9
;     /\  / \
;    () 3 7 11

; b
; 复杂度为 O(n)