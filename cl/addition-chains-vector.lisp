(defun dump-chain (chain len)
  (format t "~a " len)
  (format t "~a~%" (loop for i from 0 below len collecting (aref chain i))))

(defun addition-chain (length target &key (test-length -1))
  (declare (type fixnum length target test-length)
           (ignore test-length))
  (let ((chain (make-array target :element-type 'fixnum))
        (max-chain-length (1+ length)))
    (macrolet ((test-value (n)
                 `(progn
                    (let ((x ,n))
                      (setf (aref chain chain-length) x)
                      (if (= x target)
                          (setf ret-chain-length (1+ chain-length))
                          (if (and (< x target) (< chain-length max-chain-length))
                              (find-add-chain (1+ chain-length))))))))
      
      
      (labels ((find-add-chain (chain-length)
                 (declare (optimize (speed 3) (safety 0))
                          (type fixnum chain-length)
                          (ftype (function (fixnum) fixnum) find-add-chain))
                 (let ((ret-chain-length -1))
                   (loop for i from (1- chain-length) downto 0 while (= ret-chain-length -1) do
                        (test-value (* 2 (aref chain i)))
                        (loop for j from 0 to i while (= ret-chain-length -1) do
                             (test-value (+ (aref chain i) (aref chain j)))))
                   ret-chain-length)))
        
        (setf (aref chain 0) 1)
        (let ((chain-length (find-add-chain 1)))
          (if chain-length
              (loop for i from 0 below chain-length collecting (aref chain i))
              nil))))))

(defun addition-chain-heu (length target &key (test-length -1))
  (declare (type fixnum length target test-length)
           (ignore test-length))
  (let ((chain (make-array target :element-type 'fixnum)))
    (macrolet ((cref (n)
                 `(aref chain ,n))
               (test-value (n)
                  `(progn
                    (let ((x ,n))
                      (setf (cref chain-length) x)
                      (if (= x target)
                          (setf ret-chain-length (1+ chain-length))
                          (if (and (< x target) (< chain-length length))
                              (let ((new-chain-length (find-add-chain (1+ chain-length))))
                                (when (/= new-chain-length -1)
                                  (setf ret-chain-length new-chain-length)))))))))
               
      
      
      (labels ((find-add-chain (chain-length)
                 (declare (optimize (speed 3) (safety 0))
                          (type fixnum chain-length)
                          (ftype (function (fixnum) fixnum) find-add-chain))
                 (let ((ret-chain-length -1))
                   (cond
                     ((= chain-length 1) (test-value 2))
                     ((<= chain-length 3) (test-value (+ (cref (1- chain-length)) (cref (- chain-length 2)))))
                     ((> (* 2 (aref chain (1- chain-length))) target)
                      (loop for i from (1- chain-length) downto 0 while (= ret-chain-length -1) do
                           (loop for j from 0 to i while (= ret-chain-length -1) do
                                (test-value (+ (aref chain i) (aref chain j)))))
                      ret-chain-length)
                     (t (test-value (* 2 (aref chain (1- chain-length))))))
                   ret-chain-length)))
        
        
        (setf (aref chain 0) 1)
        (let ((chain-length (find-add-chain 1)))
          (if chain-length
              (loop for i from 0 below chain-length collecting (aref chain i))
              nil))))))
