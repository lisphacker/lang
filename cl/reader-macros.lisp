(defun parse-defun (name args return-type &rest body)
  (format t "~a~%~a~%~a~%~a~%" name args return-type body))

(defparameter *keywords* '(("defun" defun) ("pointer" :pointer) ("float" :float)))

(defun reader (s c n)
  (declare (ignore c n))
  (labels ((kw-upcase (l)
             (let ((l2 nil))
               (loop for el in l do
                    (if (listp el)
                        (push (kw-upcase el) l2)
                        (if (symbolp el)
                            (let ((sym (cadr (assoc (symbol-name el) *keywords* :test #'equalp))))
                              (if sym
                                  (push sym l2)
                                  (push (symbol-name el) l2)))
                            (push el l2))))
               (reverse l2))))
    (let ((*readtable* (copy-readtable)))
      (setf (readtable-case *readtable*) :preserve)
      (let ((l (kw-upcase (read s))))
        (format t "~a~%" l)))))
          
        
(set-dispatch-macro-character #\# #\c #'reader)

#c(defmacro defvecop (fname)
  `(defun ,fname ((:pointer :float a) (:pointer :float b) (:pointer :float c) (:int n)) :void 'aa))

#|
(defun test ()
  #c(defun vecadd ((:pointer :float a) (:pointer :float b) (:pointer :float c) (:int n)) :void 'aa))
|#
