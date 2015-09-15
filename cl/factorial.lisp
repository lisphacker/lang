(defun fac1 (x)
  (if (<= x 1)
      1
      (* x (fac1 (1- x)))))

(defun fac2 (x)
  (labels ((fac (n acc)
             (if (<= n 1)
                 acc
                 (fac (1- n) (* n acc)))))
    (fac x 1)))

(defmacro deffac (name n)
  (let ((f (fac2 n)))
    `(setf (symbol-function ',name) (lambda (n) ,f))))

