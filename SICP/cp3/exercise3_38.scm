#lang sicp

; Peter:  (set! balance (+ balance 10))
; Paul:   (set! balance (- balance 20))
; Mary:   (set! balance (- balance (/ balance 2)))

; a
; 按顺序执行，有以下几种可能
; 1. Peter -> Pual -> Mary   45
; 2. Peter -> Mary -> Pual   35 
; 3. Pual -> Peter -> Mary   45
; 4. Pual -> Mary -> Peter   50
; 5. Mary -> Peter -> Pual   40
; 6. Mary -> Pual -> Peter   40