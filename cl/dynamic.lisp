(defparameter a 1)

(defun p ()
  (format t "p: a = ~a~%" a))

(defun f ()
  (let ((a 2))
    (p)))

(defun f2 (x)
  (let ((a x))
    (p)))

(p)
(f)
(p)
(f)
