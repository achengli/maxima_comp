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

(defmfun $power_supply (V &optional &key (frec 0) (phasor false))
         "Active circuit component that brings a voltage generator
         which has the posibility to have alternate or DC current."
         (let ((v nil))
           (if phasor (setq v V)
             (setq v (lambda (t) `((mtimes simp) ,V ($cos ((mtimes simp) 2 $%pi ,frec $t))))))
           v))            

(defmfun $resistor (R &optional &key (V 0) (i 0))
         (let ((out '((Vr . `((mtimes simp) ,i ,R)) 
                       (Ir . `((rat simp) ,V R)))))
           out))

