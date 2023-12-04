(defun collatz (n)
  (if (= n 1)
      1
      (if (evenp n)
          (1+ (collatz (/ n 2)))
          (1+ (collatz (+ (* n 3) 1))))))

(defun swap (a b)
  (let ((temp (copy-seq a)))
    (setf (subseq a) b)
    (setf (subseq b) temp)))

(defun main ()
  (let ((args (cdr sb-ext:*posix-argv*))) ; Extract command line arguments
    (if (< (length args) 2)
        (format t "Please provide a range (Smallest to Largest) to calculate the longest Collatz Sequences")
        (let* ((min (parse-integer (first args)))
               (max (parse-integer (second args)))
               (sequence-lengths (make-array (list (- max min 1) 2))))
          (format t "Range: ~D -> ~D~%" min max)
          
          ;; Calculate sequence lengths and store them
          (loop for i from min to max do
            (setf (aref sequence-lengths (- i min) 0) i)
            (setf (aref sequence-lengths (- i min) 1) (collatz i)))
          
          ;; Sorting the sequence lengths array based on sequence lengths
          (dotimes (i (- max min))
            (dotimes (count (- max min i))
              (when (< (aref sequence-lengths count 1)
                       (aref sequence-lengths (+ count 1) 1))
                (swap (aref sequence-lengths count)
                      (aref sequence-lengths (+ count 1))))))
          
          ;; Display top 10 sequences based on length
          (format t "Sorted based on sequence length~%")
          (dotimes (i (min 10 (length sequence-lengths)))
            (format t "      ~D          ~D~%" (aref sequence-lengths i 0) (aref sequence-lengths i 1))))
          
          ;; Selecting and sorting the top 10 numbers by their numerical value
          (let ((top-10-numbers (mapcar #'first (subseq sequence-lengths 0 (min 10 (length sequence-lengths)))))) 
            (sort top-10-numbers #'<)
            (format t "Sorted based on integer size~%")
            (dolist (number (reverse top-10-numbers))
              (format t "      ~D           ~D~%" number (second (find number sequence-lengths :key #'first :test #'=))))))))