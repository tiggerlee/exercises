(define (f g)
  (g 2))

(f f)
; 在MIT-scheme中会报错：The object 2 is not applicable.
; (f f) -> (f 2) -> (2 2)
; 而2不是一个运算符
