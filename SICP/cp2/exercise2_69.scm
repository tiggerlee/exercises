#lang sicp

(define (make-leaf symbol weight)
  (list 'leaf symbol weight))

(define (leaf? object)
  (eq? (car object) 'leaf))

(define (symbol-leaf x) (cadr x))

(define (weight-leaf x) (caddr x))

(define (make-code-tree left right)
  (list left
        right
        (append (symbols left) (symbols right))
        (+ (weight left) (weight right))))

(define (left-branch tree) (car tree))

(define (right-branch tree) (cadr tree))

(define (symbols tree)
  (if (leaf? tree)
      (list (symbol-leaf tree))
      (caddr tree)))

(define (weight tree)
  (if (leaf? tree)
      (weight-leaf tree)
      (cadddr tree)))

(define (decode bits tree)
  (define (decode-1 bits current-branch)
    (if (null? bits)
        '()
        (let ((next-branch
               (choose-branch (car bits) current-branch)))
          (if (leaf? next-branch)
              (cons (symbol-leaf next-branch)
                    (decode-1 (cdr bits) tree))
              (decode-1 (cdr bits) next-branch)))))
  (decode-1 bits tree))

(define (choose-branch bit branch)
  (cond ((= bit 0) (left-branch branch))
        ((= bit 1) (right-branch branch))
        (else (error "bad bit -- CHOOSE-BRANCH" bit))))

(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((< (weight x) (weight (car set))) (cons x set))
        (else (cons (car set)
                    (adjoin-set x (cdr set))))))

(define (make-leaf-set pairs)
  (if (null? pairs)
      '()
      (let ((pair (car pairs)))
        (adjoin-set (make-leaf (car pair)
                               (cadr pair))
                    (make-leaf-set (cdr pairs))))))

(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))

(define (include-symbol? symbol tree)
  (define (symbol-found? symbols)
    (cond ((null? symbols) #f)
          ((eq? (car symbols) symbol) #t)
          (else (symbol-found? (cdr symbols)))))
  (if (null? tree)
      #f
      (symbol-found? (symbols tree))))

(define (encode-symbol char tree)
  (cond ((leaf? tree) '())
        ((include-symbol? char (left-branch tree))
         (cons 0 (encode-symbol char (left-branch tree))))
        ((include-symbol? char (right-branch tree))
         (cons 1 (encode-symbol char (right-branch tree))))
        (else (error "symbole not in this tree" char))))

(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

; 1. 如果当前列表的长度大于1 则取出 列表第一项和第二项，使用 make-code-tree 方法生成新的树
; 2. 将新生成的树按照权重顺序添加到除 第一项和第二项的剩余列表中
; 3. 一直重复这个过程，直到列表中只有一项，这一项即为构造完成的树
(define (successive-merge set)
  (if (null? (cdr set))
      (car set)
      (successive-merge
       (adjoin-set (make-code-tree (car set) (cadr set))
                   (cddr set)))))

(define tree (generate-huffman-tree '((A 4) (B 2) (C 1) (D 1))))

(define encode-sample (encode '(A B A C) tree))
(display (decode encode-sample tree)) ; (A B A C)