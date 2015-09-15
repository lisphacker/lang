(defun test ()
  (loop for i from 0 to 10 do
       q(log:info "Hello ~a~%" i)))
