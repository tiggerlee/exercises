#lang sicp

(define (make-tree node left right)
  (list node left right))

(define (left-branch tree)
  (cadr tree))

(define (right-branch tree)
  (caddr tree))

(define (entry tree)
  (car tree))

(define (empty-tree? tree)
  (null? tree))

(define (set-left-branch! branch tree)
  (set-car! (cdr tree) branch))

(define (set-right-branch! branch tree)
  (set-car! (cddr tree) branch))

(define (set-tree-value! value tree)
  (set-car! tree value))

(define (make-node key value)
  (cons key value))

(define (node-key node)
  (car node))

(define (node-value node)
  (cdr node))

(define (tree-lookup key tree)
  (if (empty-tree? tree)
      nil
      (cond ((eq? key (node-key (entry tree)))
              tree)
            ((< key (node-key (entry tree)))
              (tree-lookup key (left-branch tree)))
            (else (tree-lookup key (right-branch tree))))))

(define (tree-insert! node tree)
  (if (empty-tree? tree)
      (make-tree node nil nil)
      (let ((current-key (node-key (entry tree)))
            (given-key (node-key node)))
        (cond ((eq? current-key given-key)
                (set-tree-value! node tree)
                tree)
              ((> current-key given-key)
                (set-left-branch!
                  (tree-insert! node (left-branch tree))
                  tree)
                tree)
              (else 
                (set-right-branch!
                  (tree-insert! node (right-branch tree))
                  tree)
                tree)))))

(define (make-table)
  (let ((local-tree nil))
    (define (insert! key value)
      (let ((node (make-node key value)))
        (set! local-tree (tree-insert! node local-tree))
        local-tree))
    (define (loopup key)
      (let ((tree (tree-lookup key local-tree)))
        (if (null? tree)
            #f
            (node-value (entry tree)))))

    (define (dispatch m)
      (cond ((eq? m 'insert!) insert!)
            ((eq? m 'loopup) loopup)
            (else (error "No such a method " m))))
    dispatch))

(define t (make-table))
((t 'insert!) 5 'a)
((t 'insert!) 3 'b)
((t 'insert!) 7 'c)
((t 'loopup) 3)
((t 'loopup) 7)
((t 'loopup) 4)
((t 'insert!) 4 'd)
((t 'insert!) 2 'e)
((t 'insert!) 8 'f)
((t 'insert!) 9 'g)
((t 'loopup) 2)
((t 'loopup) 8)
((t 'loopup) 4)
((t 'insert!) 5 'h)
((t 'loopup) 5)
((t 'insert!) 4 'i)
((t 'loopup) 4)