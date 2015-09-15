(defun addition-chain (length target)
  (labels ((find-add-chain (chain chain-length length target)
             (if (and (= chain-length length) (= (car chain) target))
                 chain
                 (if (= chain-length length)
                     nil
                     (if (> (car chain) target)
                         nil
                         (let ((ret-chain nil))
                           (loop for x in chain while (not ret-chain) do
                                (loop for y in chain while (not ret-chain) do
                                     (let ((new-chain (find-add-chain (cons (+ x y) chain)
                                                                      (1+ chain-length)
                                                                      length
                                                                      target)))

                                       (when new-chain
                                         (setf ret-chain new-chain)))))
                           ret-chain))))))
    
    (reverse (find-add-chain '(1) 1 (1+ length) target))))
