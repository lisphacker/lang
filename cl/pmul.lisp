(defun vecmul (a b c)
  (declare (optimize (safety 0) (speed 3)) (type (simple-array single-float 1) a b c))
  (assert (= (array-dimension a 0) (array-dimension b 0) (array-dimension c 0)))
  (loop for i from 0 below (array-dimension a 0) do
       (setf (aref c i) (* (aref a i) (aref b i)))))

(defmacro make-adder (n)
  (let ((adder-sym (intern (format nil "ADD~a" n) :common-lisp-user)))
    `(defun ,adder-sym (x) (+ x ,n))))
