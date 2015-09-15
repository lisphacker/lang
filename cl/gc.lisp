(defclass vec ()
  ((x :initarg :x
      :accessor x)
   (y :initarg :y
      :accessor y)))

(defmethod initialize-instance ((v vec) &key x y)
  (format t "INIT~%")
  (setf (slot-value v 'x) x
        (slot-value v 'y) y)
  (finalize v (lambda () (ci)))
  v)

(defun ci ()
  (format t "CI~%"))

(defmethod cleanup-instance ((v vec))
  (format t "CLEANUP~%")
  (setf (slot-value v 'x) 0
        (slot-value v 'y) 0))

(defun test ()
  (let ((x (make-instance 'vec :x 10 :y 20)))
    (format t "~a~%" x)))
