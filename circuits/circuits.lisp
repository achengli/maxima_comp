;; Lisp circuits functions
;; -------
;; Copyright (C) BY-NC 2025 - Yassin Achengli <achengli@github.com>
;; This file is under BSD clause 3 license.

(defstruct circuits:element
  name
  description
  value
  nodes
  function)

(defmacro circuits:new-element (&rest args)
  (make-circuits:circuit @,args))

(defstruct circuits:circuit
  name
  description
  nodes
  elements)

(defmacro circuits:new-circuit (&rest args)
  (make-circuits:circuit @,args))

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

(defstruct circuit-block 
  "`circuit-block' emulates a circuit element with the given parameters:

  - `active-or-pasive' set active or pasive element (nil for pasive).
  - `thevenin-impedance-func' is the impedance when having impedance circuits.
  - `thevenin-admitance-func' is the same as above but for admitance circuits.
  - `thevenin-voltage' is the Thevenin equivalent Voltage for impedance circuits.
  - `norton-current' is the Norton theorem equivalent current for admitance circuits.
  - `node-contection' is the point where this element is located on the circuit diagram."
  active-or-pasive
  thevenin-impedance-func
  thevenin-admitance-func
  thevenin-voltage
  node-connection)


(defun new-circuit-net (&key impedance-or-admitance (node-list '()) (mesh-list '()))
  "New electric circuit net built with mesh grids and elements which are conected between
  nodes."
  (let ((n nil))
    (loop for mesh in mesh-list do
          (assert (has mesh node-list)))
    (make-circuit-net :node-list node-list
                      :mesh-list mesh-list)))
