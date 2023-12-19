;; Lisp circuits functions
;; -------
;; Author: Yassin Achengli <achengli@github.com>

(defmfun $parallel (&rest par)
         "Takes a variadic number of impedances and gives the 
         result of the parallel sum."
         (let ((acum 0))
           (loop for i in par do
                 (setq acum `((mplus simp) ,acum 
                    ((mexpt simp) ,i -1))))
           (setq acum `((mexpt simp) ,acum -1))
           ($expand acum)))

(defmfun $series (&rest par)
         "Takes a variadic number of impedances and return the 
         result of the series sum."
         (let ((acum (car par)))
           (loop for i in (cdr par) do
                 (setq acum `((mplus simp) ,acum ,i)))
           ($expand acum)))

(defmfun $complexp (c)
         (if (equal 0 ($imagpart c)) nil t))


