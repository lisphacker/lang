(defclass vec2 ()
  ((x :initarg       :x
      :initform      0
      :type          'single-float
      :accessor      x
      :documentation "X")
   (y :initarg       :y
      :initform      0
      :type          'single-float
      :accessor      y
      :documentation "Y"))
  (:documentation "2D vector"))

(defclass vec3 (vec2)
  ((z :initarg       :z
      :initform      0
      :type          'single-float
      :accessor      z
      :documentation "Z"))
  (:documentation "3D vector"))

(defun test1 ()
  (describe (make-instance 'vec3 :x 10 :y 20 :z 30)))
