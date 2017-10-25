; 参考 http://sicp.readthedocs.io/en/latest/chp3/29.html

; 延迟时间因为使用了 and-gate 和 inverter，所以由前面两者的延迟时间决定
; 因为调用了三次 inverter 和一次 and-gate，所以延迟时间为 3*inverter-delay + and-gate-delay

(define (or-gate input1 input2 output)
  (let ((connect-input1-inverter1 (make-wire))
        (connect-input2-inverter2 (make-wire))
        (connect-and-gate-inverters (make-wire)))
    (inverter input1 connect-input1-inverter1)
    (inverter input2 connect-input2-inverter2)
    (and-gate connect-input1-inverter1 connect-input2-inverter2 connect-and-gate-inverters)
    (inverter connect-and-gate-inverters output))
  'ok)