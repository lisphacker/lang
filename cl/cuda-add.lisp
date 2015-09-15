(in-package :cl-user)
(defpackage :cuda-add
  (:use :cl
        :cl-cuda)
  (:export :main))
(in-package :cuda-add)

(defun set-mem (mem-block n val)
  (dotimes (i n)
    (setf (memory-block-aref mem-block i) val)))

(defkernel add-kernel (void ((a float*) (b float*) (c float*) (n int)))
  (let ((i thread-idx-x))
    (when (< i n)
      (set (aref c i) (+ (aref a i) (aref b i))))))
  
    
(defun main ()
  (let ((n 256))
    (with-cuda (0)
      (with-memory-blocks ((a 'float n)
                           (b 'float n)
                           (c 'float n))
        (set-mem a n 1.0)
        (set-mem b n 2.0)
        (set-mem c n 0.0)

        (sync-memory-block a :host-to-device)
        (sync-memory-block b :host-to-device)
        (sync-memory-block c :host-to-device)

        (add-kernel a b c n
                    :grid-dim '(1 1 1)
                    :block-dim '(256 1 1))

        (sync-memory-block c :device-to-host)

        (format t "~a ~a ~a~%"
                (memory-block-aref c 0)
                (memory-block-aref c 10)
                (memory-block-aref c 100))))))
