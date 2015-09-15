(compile-file "parse.lisp")
(load "parse")

(defmacro defcfn (fn vars &body code)
  (parse-c-function fn vars code)
  `(defun ,fn ,vars ,@code))

(defmacro defop (op fn-prefix)
  (macrolet ((make-op (prefix count)
               `(read-from-string (format nil "~a~a" ,prefix ,count))))
    `(progn
       (defcfn ,(make-op fn-prefix 1) (a b) (,op a b))
       (defcfn ,(make-op fn-prefix 2) (a b) (,op a b))
       (defcfn ,(make-op fn-prefix 3) (a b) (,op a b))
       (defcfn ,(make-op fn-prefix 4) (a b) (,op a b))
       (defcfn ,(make-op fn-prefix 5) (a b) (,op a b)))))
