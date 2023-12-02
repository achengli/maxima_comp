;; Lisp circuits functions
;; -------

;; circuit parallel impedances
(defun parallel (&rest impedance)
  (let ((acum 0.0))
    (dolist (i impedance)
      (setq acum (+ acum (if (not (listp i)) (/ 1 i)
                   (parallel-list i)))))
    (/ 1 acum)))

(defun parallel-list (impedance)
  (let ((acum .0))
    (dolist (i impedance)
      (setq acum  (+ acum (if (not (listp i))
                            (/ 1 i)
                            (parallel-list i)))))
    (/ 1 acum)))

;; circuit series impedances
(defun series (&rest impedance)
  (let ((acum 0.0))
    (dolist (i impedance)
      (setq acum (+ acum (if (not (listp i)) i
                   (series-list i)))))
    acum))

(defun series-list (impedance)
  (let ((acum .0))
    (dolist (i impedance)
      (setq acum  (+ acum (if (not (listp i))
                            i
                            (series-list i)))))
    acum))


;; demo
(let ((*demo-values* (list '(123 4 34.9 334.22))))
  (defun main()
    (progn
      (dolist (l *demo-values*)
        (progn 
          (print (series (values-list l)))
          (print (parallel (values-list l)))))
      (print (series *demo-values*)))))
