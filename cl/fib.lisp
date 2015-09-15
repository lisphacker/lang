(defun fib (n &optional (a 0) (b 1))
  (if (zerop n)
      nil
      (cons a (fib (1- n) b (+ a b)))))

      
