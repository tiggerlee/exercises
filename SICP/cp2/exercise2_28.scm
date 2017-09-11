#lang sicp

(define x (list (list 1 2) (list 3 4)))

; 递归版本
; 遇到空列表 返回 nil
; 遇到叶子 返回 (list x)
; 其他情况 append左右分支的结果
(define (fringe-recu x)
  (cond ((null? x) nil)
        ((not (pair? x)) (list x))
        (else (append (fringe-recu (car x))
                      (fringe-recu (cdr x))))))

; 迭代版本
(define (fringe-iter x)
  (define (iter l r)
    ; 遇到空列表 返回结果 r
    ; 不是叶子 总结果为左分支结果和右分支结果加上已经累计的结果 r
    ; 是叶子 将当前叶子节点累加到已累积结果中
    (cond ((null? l) r)
          ((pair? l) (iter (car l) (iter (cdr l) r)))
          (else (cons l r))))
  (iter x nil))

(fringe-recu x)
(fringe-recu (list x x))
(fringe-iter x)
; 替换模型计算过程
; (iter (1 2) (iter (3 4) nil))
; (iter (1 2) (iter 3 (iter (4) nil)))
; (iter (1 2) (iter 3 (iter 4 (iter nil nil))))
; (iter (1 2) (iter 3 (iter 4 nil)))
; (iter (1 2) (iter 3 (cons 4 nil)))
; (iter (1 2) (iter 3 (4)))
; (iter (1 2) (cons 3 (4)))
; (iter (1 2) (3 4))
; (iter 1 (iter (2) (3 4))
; (iter 1 (iter 2 (iter nil (3 4)))
; (iter 1 (iter 2 (3 4))
; (iter 1 (cons 2 (3 4))
; (cons 1 (cons 2 (3 4))
; (1 2 3 4)
(fringe-iter (list x x))