(defclass A ()
  ((x :initarg :x :accessor x))
  (:documentation "A"))

(defmethod dump ((a A) prefix)
  (format t "~a ~a~%" prefix (x a)))
    
(defclass B (A)
  ((y :initarg :y :accessor y))
  (:documentation "B"))

(defmethod dump ((b B) prefix)
  (call-next-method)
  (format t "~a ~a~%" prefix (y b)))

(defun test ()
  (let ((a (make-instance 'A :x 10))
        (b (make-instance 'B :x 20 :y 30)))
    (dump a "A")
    (dump b "B")))
