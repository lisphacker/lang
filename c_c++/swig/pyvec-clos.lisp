
(cl:defclass py-vec()
  ((ff-pointer :reader ff-pointer)))

(cl:defmethod initialize-instance :after ((obj py-vec) &key (n cl:integer))
  (setf (slot-value obj 'ff-pointer) (new_PyVec n)))

