(asdf:oos 'asdf:load-op :cffi)
   
;;; Nothing special about the "CFFI-USER" package.  We're just
;;; using it as a substitute for your own CL package.
(defpackage :cffi-user
  (:use :common-lisp :cffi))

(in-package :cffi-user)

(define-foreign-library libvec
  (:unix "/home/gautham/work/lang/cl/cffi-vec/libvec.so")
  (t (:default "libvec")))

(use-foreign-library libvec)

(defclass farray ()
  ((size :initform      :size
         :initargs      (error ":size must be specified")
         :type          'integer
         :reader        size
         :documentation "Size of the array in elements")
   (data :initform      :data
         :initargs      nil
         :type          'pointer
         :reader        data
         :documentation "Size of the array in elements"))
  (:documentation "Foreign array"))

(defmethod print-object ((array farray) stream)
  (format stream "[")
  (loop for i from 0 below (size array) do
       (when (/= i 0) (format stream ", "))
       (format stream "~a" (mem-aref (data array) :float i)))
  (format stream "]"))

(defmethod initialize-instance ((array farray) &key size (initial-contents nil))
  (setf (slot-value array 'size) size)
  (setf (slot-value array 'data) (foreign-alloc :float :count size :initial-contents initial-contents))
  array)

;;(defmethod print

#|

(defun sum2 (ar)
  (let ((len (array-total-size ar)))
    (foreign-funcall "sum" :pointer ar :int len :float)))
|#

(defcfun "sum" :float
  (ar :pointer)
  (n :int))

(defun test ()
  (let ((ar (make-instance 'farray :size 9 :initial-contents '(0.0 1.0 2.0 3.0 4.0 5.0 6.0 7.0 8.0))))
    (format t "~a~%" ar)
    ;;(format t "~a~%" (sum ar 9))
    ;;(format t "~a~%" (sum ar2))
    (make-instance 'farray :size 9)
    (format t "~a~%" ar)))
