#lang sicp

(define (look-up given-key set-of-records)
  (cond ((null? set-of-records) #f)
        ((equal? given-key (key (entry set-of-records))) 
            (entry set-of-records))
        ((< given-key (key (entry set-of-records))) 
            (look-up given-key (left-branch set-of-records)))
        ((> given-key (key (entry set-of-records))) 
            (look-up given-key (right-branch set-of-records)))))