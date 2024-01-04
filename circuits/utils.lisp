(defmacro has-some (v1 v2)
  `(let ((segment t))
    (dolist (i ,v1)
      (setq segment (and (member i ,v2))))
    segment))

(progn 
  (print (has-some '(e f) '(b c a))))
