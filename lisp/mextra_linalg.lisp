;;; -*- Mode: Lisp; package:maxima; syntax:common-lisp ;Base: 10 -*- ;;;

; Translated on: 2023-08-01 13:39:34+02:00
; Maxima version: 5.47.0
; Lisp implementation: ECL
; Lisp version: 21.2.1
;
; Translator state vars:
;
;   translate_fast_arrays: false;
;   tr_function_call_default: general;
;   tr_bound_function_applyp: true;
;   tr_array_as_ref: true;
;   tr_numer: false;
;   tr_float_can_branch_complex: true;
;   define_variable: false;

(in-package :maxima)

(progn
 (defprop $mextra_gramschmidt t translated)
 (add2lnc '$mextra_gramschmidt $props)
 (defmtrfun ($mextra_gramschmidt $any mdefine nil nil)
      ($mat)
    (declare (special $mat))
    ((lambda ($orto $mat_size $vk $acum)
       (declare (special $acum $vk $mat_size $orto))
       (let ()
         (declare (special $orto))
         (if (not (boundp '$orto)) (add2lnc '$orto $values))
         (setq $orto
                 (simplify
                  ($zeromatrix (marrayref $mat_size 1.)
                               (marrayref $mat_size 2.)))))
       (do (($i 1. (+ 1. $i)))
           ((let (($prederror t))
              ($is-boole-eval
               (simplify (list '(mgreaterp) $i (marrayref $mat_size 2.)))))
            '$done)
         (declare (special $i))
         (let ()
           (declare (special $acum))
           (if (not (boundp '$acum)) (add2lnc '$acum $values))
           (setq $acum 0.0))
         (let ()
           (declare (special $vk))
           (if (not (boundp '$vk)) (add2lnc '$vk $values))
           (setq $vk (simplify (mfunction-call $mextra_col $mat $i))))
         (do (($j 1. (+ 1. $j)))
             ((let (($prederror t))
                ($is-boole-eval (simplify (list '(mgreaterp) $j (+ $i -1.)))))
              '$done)
           (declare (special $j))
           (let ()
             (declare (special $acum))
             (if (not (boundp '$acum)) (add2lnc '$acum $values))
             (setq $acum
                     (add* $acum
                           (mul*
                            (div
                             (ncmul2 (simplify ($transpose $vk))
                                     (simplify
                                      (mfunction-call $mextra_col $orto $j)))
                             (ncmul2
                              (simplify
                               ($transpose
                                (simplify
                                 (mfunction-call $mextra_col $orto $j))))
                              (simplify
                               (mfunction-call $mextra_col $orto $j))))
                            (simplify
                             (mfunction-call $mextra_col $orto $j)))))))
         ($print $orto)
         (let ()
           (declare (special $orto))
           (if (not (boundp '$orto)) (add2lnc '$orto $values))
           (setq $orto
                   (simplify
                    (mfunction-call $mextra_set_col
                                    $orto
                                    $i
                                    (simplify
                                     ($transpose
                                      (add* $vk (*mminus $acum)))))))))
       $orto)
     (simplify ($matrix '((mlist))))
     (simplify (mfunction-call $matrix_size $mat)) '((mlist)) 0.0)
    ))
(let ()
  (declare (special $mextra_linalg_p))
  (if (not (boundp '$mextra_linalg_p)) (add2lnc '$mextra_linalg_p $values))
  (defparameter $mextra_linalg_p t))