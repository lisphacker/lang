(progn
  (defun make-adder (x) (lambda (y) (+ y x)))
  (defun make-subtracter (x) (lambda (y) (- y x))))

(defmacro make-ops (x)
  (macrolet ((make-op (prefix)
               `(read-from-string (format nil "~a~a" ,prefix x))))
    `(progn
       (defun ,(make-op "add") (y) (+ y ,x))
       (defun ,(make-op "sub") (y) (- y ,x)))))
