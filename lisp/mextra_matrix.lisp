;;; -*- Mode: Lisp; package:maxima; syntax:common-lisp ;Base: 10 -*- ;;;

; Translated on: 2023-07-31 12:05:04+02:00
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
 (defprop $mextra_set_column t translated)
 (add2lnc '$mextra_set_column $props)
 (defmtrfun ($mextra_set_column $any mdefine nil nil)
      ($mat $c $col_val)
    (declare (special $col_val $c $mat))
    ((lambda ($m)
       (declare (special $m))
       (prog ()
         (cond
          ((not ($matrixp $mat))
           (simplify ($error "The entered `mat` value is not a valid matrix."))
           (return nil)))
         (marrayset $col_val $m $c)
         (return (simplify ($transpose $m)))))
     (simplify ($transpose $mat)))
    ))
(progn
 (defprop $mextra_col t translated)
 (add2lnc '$mextra_col $props)
 (defmtrfun ($mextra_col $any mdefine nil nil)
      ($mat $c)
    (declare (special $c $mat))
    (simplify
     ($transpose (marrayref 'mqapply (simplify ($transpose $mat)) $c)))
    ))
(progn
 (defprop $mextra_random_matrix t translated)
 (add2lnc '$mextra_random_matrix $props)
 (defmtrfun ($mextra_random_matrix $any mdefine nil nil)
      ($n $m)
    (declare (special $m $n))
    ((lambda ($mat)
       (declare (special $mat))
       (prog ()
         (let (tr-gensym10)
           (cond
            ((eq t
                 (setq tr-gensym10
                         (mcond-boole-verify
                          (mnot_tr
                           (mcond-boole-verify
                            (mand_tr ($integerp $n)
                                     ($integerp $m)
                                     (mcond-boole-verify (mgqp $m 1.))
                                     (mcond-boole-verify (mgqp $n 1.))))))))
             (simplify
              ($error
               "The entered scalars `m` and `n` are not valid scalar dimension")))
            ((not (null tr-gensym10))
             (list* '(mcond)
                    tr-gensym10
                    (mapcar #'mcond-eval-symbols-tr
                            '((($error (30. "mextra_matrix.mac" src))
                               "The entered scalars `m` and `n` are not valid scalar dimension")
                              t $false))))))
         (do (($i 1. (+ 1. $i)))
             ((let (($prederror t))
                ($is-boole-eval (simplify (list '(mgreaterp) $i $n))))
              '$done)
           (declare (special $i))
           (do (($j 1. (+ 1. $j)))
               ((let (($prederror t))
                  ($is-boole-eval (simplify (list '(mgreaterp) $j $m))))
                '$done)
             (declare (special $j))
             (marrayset ($random nil) 'mqapply (marrayref $mat $i) $j)))
         (return $mat)))
     (simplify ($matrix '((mlist)))))
    ))
(progn
 (defprop $mextra_minor_matrix t translated)
 (add2lnc '$mextra_minor_matrix $props)
 (defmtrfun ($mextra_minor_matrix $any mdefine nil nil)
      ($mat $from_row $to_row $from_col $to_col)
    (declare (special $to_col $from_col $to_row $from_row $mat))
    ((lambda ($m)
       (declare (special $m))
       (let (tr-gensym11)
         (cond
          ((not ($matrixp $mat))
           (simplify ($error "`mat` input is not a valid matrix")))
          ((eq t
               (setq tr-gensym11
                       (mcond-boole-verify
                        (mor_tr
                         (not
                          (and ($integerp $from_row)
                               ($integerp $to_row)
                               ($integerp $from_col)
                               ($integerp $to_col)))
                         (mcond-boole-verify (mlsp $from_row 1.))
                         (mcond-boole-verify (mlsp $to_row 1.))
                         (mcond-boole-verify (mlsp $from_col 1.))
                         (mcond-boole-verify (mlsp $to_col 1.))))))
           (simplify
            ($error
             "from and to row and column inputs must be integers from 1 to `mat` size.")))
          ((not (null tr-gensym11))
           (list* '(mcond)
                  tr-gensym11
                  (mapcar #'mcond-eval-symbols-tr
                          '((($error (44. "mextra_matrix.mac" src))
                             "from and to row and column inputs must be integers from 1 to `mat` size.")
                            t $false))))))
       (let ()
         (declare (special $m))
         (if (not (boundp '$m)) (add2lnc '$m $values))
         (setq $m
                 (simplify
                  ($zeromatrix (add* $to_row (*mminus $from_row))
                               (add* $to_col (*mminus $from_col))))))
       (do (($i $from_row (+ 1. $i)))
           ((let (($prederror t))
              ($is-boole-eval (simplify (list '(mgreaterp) $i $to_row))))
            '$done)
         (declare (special $i))
         (do (($j $from_col (+ 1. $j)))
             ((let (($prederror t))
                ($is-boole-eval (simplify (list '(mgreaterp) $j $to_col))))
              '$done)
           (declare (special $j))
           (marrayset (marrayref 'mqapply (marrayref $mat $i) $j)
                      'mqapply
                      (marrayref $m (add* $i (*mminus $from_row) 1.))
                      (add* $j (*mminus $from_col) 1.))))
       $m)
     (simplify ($matrix '((mlist)))))
    ))
(progn
 (defprop $mextra_reduce t translated)
 (add2lnc '$mextra_reduce $props)
 (defmtrfun ($mextra_reduce $any mdefine nil nil)
      ($lambda_fn $mat)
    (declare (special $mat $lambda_fn))
    ((lambda ($acum)
       (declare (special $acum))
       (do (($i)
            (mdo (cdr $mat) (cdr mdo)))
           ((null mdo) '$done)
         (declare (special $i))
         (setq $i (car mdo))
         (do (($j)
              (mdo (cdr $i) (cdr mdo)))
             ((null mdo) '$done)
           (declare (special $j))
           (setq $j (car mdo))
           (let ()
             (declare (special $acum))
             (if (not (boundp '$acum)) (add2lnc '$acum $values))
             (setq $acum (simplify (mfuncall $lambda_fn $acum $j))))))
       $acum)
     0.0)
    ))
(progn
 (defprop $mextra_sum t translated)
 (add2lnc '$mextra_sum $props)
 (defmtrfun ($mextra_sum $any mdefine nil nil)
      ($mat)
    (declare (special $mat))
    (simplify
     ($mextra_reduce
      (m-tlambda ($acum $x) (declare (special $x $acum)) (add* $acum $x))
      $mat))
    ))
(progn
 (defprop $mextra_sub t translated)
 (add2lnc '$mextra_sub $props)
 (defmtrfun ($mextra_sub $any mdefine nil nil)
      ($mat)
    (declare (special $mat))
    (simplify
     ($mextra_reduce
      (m-tlambda ($acum $x)
                 (declare (special $x $acum))
                 (add* $acum (*mminus $x)))
      $mat))
    ))
(progn
 (defprop $mextra_mod t translated)
 (add2lnc '$mextra_mod $props)
 (defmtrfun ($mextra_mod $any mdefine nil nil)
      ($mat)
    (declare (special $mat))
    (div $mat (simplify ($mextra_sum $mat)))
    ))
(progn
 (defprop $mextra_filter t translated)
 (add2lnc '$mextra_filter $props)
 (defmtrfun ($mextra_filter $any mdefine nil nil)
      ($lambda_fn $mat)
    (declare (special $mat $lambda_fn))
    ((lambda ($ret $mat_size)
       (declare (special $mat_size $ret))
       (do (($i 1. (+ 1. $i)))
           ((let (($prederror t))
              ($is-boole-eval
               (simplify (list '(mgreaterp) $i (marrayref $mat_size 1.)))))
            '$done)
         (declare (special $i))
         (do (($j 1. (+ 1. $j)))
             ((let (($prederror t))
                ($is-boole-eval
                 (simplify (list '(mgreaterp) $j (marrayref $mat_size 2.)))))
              '$done)
           (declare (special $j))
           (let (tr-gensym12)
             (cond
              ((eq t
                   (setq tr-gensym12
                           (mcond-boole-verify
                            (mnot_tr
                             (mcond-boole-eval
                              (simplify
                               (mfuncall $lambda_fn
                                         (marrayref 'mqapply
                                                    (marrayref $mat $i)
                                                    $j))))))))
               (let ()
                 (declare (special $ret))
                 (if (not (boundp '$ret)) (add2lnc '$ret $values))
                 (setq $ret
                         ($append $ret
                                  (list '(mlist)
                                        (marrayref 'mqapply
                                                   (marrayref $mat $i)
                                                   $j))))))
              ((not (null tr-gensym12))
               (list* '(mcond)
                      tr-gensym12
                      (mapcar #'mcond-eval-symbols-tr
                              '(((msetq (68. "mextra_matrix.mac" src)) $ret
                                 (($append (68. "mextra_matrix.mac" src)) $ret
                                  ((mlist (68. "mextra_matrix.mac" src))
                                   ((mqapply array
                                     (68. "mextra_matrix.mac" src))
                                    (($mat array (68. "mextra_matrix.mac" src))
                                     $i)
                                    $j))))
                                t $false))))))))
       $ret)
     '((mlist)) (simplify (mfunction-call $matrix_size $mat)))
    ))
(progn
 (defprop $mextra_lower_than t translated)
 (add2lnc '$mextra_lower_than $props)
 (defmtrfun ($mextra_lower_than $any mdefine nil nil)
      ($shirt $mat)
    (declare (special $mat $shirt))
    (simplify
     ($mextra_filter
      (m-tlambda&env (($x) ($shirt) nil)
                     (declare (special $x))
                     (simplify (list '(mlessp) $x $shirt)))
      $mat))
    ))
(progn
 (defprop $mextra_lower_than t translated)
 (add2lnc '$mextra_lower_than $props)
 (defmtrfun ($mextra_lower_than $any mdefine nil nil)
      ($shirt $mat)
    (declare (special $mat $shirt))
    (simplify
     ($mextra_filter
      (m-tlambda&env (($x) ($shirt) nil)
                     (declare (special $x))
                     (simplify (list '(mgreaterp) $x $shirt)))
      $mat))
    ))
(progn
 (defprop $mextra_equal_to t translated)
 (add2lnc '$mextra_equal_to $props)
 (defmtrfun ($mextra_equal_to $any mdefine nil nil)
      ($val $mat)
    (declare (special $mat $val))
    (simplify
     ($mextra_filter
      (m-tlambda&env (($x) ($val) nil)
                     (declare (special $x))
                     (simplify (list '(mlessp) $x $val)))
      $mat))
    ))
(progn
 (defprop $mextra_reshape t translated)
 (add2lnc '$mextra_reshape $props)
 (defmtrfun ($mextra_reshape $any mdefine nil nil)
      ($mat $n $m)
    (declare (special $m $n $mat))
    ((lambda ($ret $mat_size)
       (declare (special $mat_size $ret))
       (let (tr-gensym13)
         (cond
          ((eq t
               (setq tr-gensym13
                       (mcond-boole-verify
                        (mgrp (mul* $n $m)
                              (mul* (marrayref $mat_size 1.)
                                    (marrayref $mat_size 2.))))))
           (simplify ($error "Sizes mismatch")))
          ((not (null tr-gensym13))
           (list* '(mcond)
                  tr-gensym13
                  (mapcar #'mcond-eval-symbols-tr
                          '((($error (78. "mextra_matrix.mac" src))
                             "Sizes mismatch")
                            t
                            ((mcond (79. "mextra_matrix.mac" src))
                             ((mor (79. "mextra_matrix.mac" src))
                              ((mor (79. "mextra_matrix.mac" src))
                               ((mlessp (79. "mextra_matrix.mac" src)) $n 1.)
                               ((mlessp (79. "mextra_matrix.mac" src)) $m 1.))
                              ((mnot (79. "mextra_matrix.mac" src))
                               ((mand (79. "mextra_matrix.mac" src))
                                (($integerp (79. "mextra_matrix.mac" src)) $n)
                                (($integerp (79. "mextra_matrix.mac" src))
                                 $n))))
                             (($error (80. "mextra_matrix.mac" src))
                              "n and m must be positive integers greater than 0")
                             t $false)))))
          ((eq t
               (setq tr-gensym13
                       (mcond-boole-verify
                        (mor_tr
                         (mcond-boole-verify
                          (mor_tr (mcond-boole-verify (mlsp $n 1.))
                                  (mcond-boole-verify (mlsp $m 1.))))
                         (not (and ($integerp $n) ($integerp $n)))))))
           (simplify
            ($error "n and m must be positive integers greater than 0")))
          ((not (null tr-gensym13))
           (list* '(mcond)
                  tr-gensym13
                  (mapcar #'mcond-eval-symbols-tr
                          '((($error (80. "mextra_matrix.mac" src))
                             "n and m must be positive integers greater than 0")
                            t $false))))))
       (let ()
         (declare (special $mat))
         (if (not (boundp '$mat)) (add2lnc '$mat $values))
         (setq $mat (simplify ($zeromatrix $n $m))))
       (do (($i 1. (+ 1. $i)))
           ((let (($prederror t))
              ($is-boole-eval (simplify (list '(mgreaterp) $i $n))))
            '$done)
         (declare (special $i))
         (do (($j 1. (+ 1. $j)))
             ((let (($prederror t))
                ($is-boole-eval (simplify (list '(mgreaterp) $j $m))))
              '$done)
           (declare (special $j))
           (marrayset
            (marrayref $mat
                       (add*
                        (simplify
                         (list '($floor) (div $i (marrayref $mat_size 1.))))
                        1.)
                       (add*
                        (simplify (list '($mod) $j (marrayref $mat_size 1.)))
                        1.))
            'mqapply
            (marrayref $ret $i)
            $j)))
       $ret)
     (simplify ($matrix '((mlist))))
     (simplify (mfunction-call $matrix_size $mat)))
    ))
(progn
 (defprop $mextra_gramschmidt t translated)
 (add2lnc '$mextra_gramschmidt $props)
 (defmtrfun ($mextra_gramschmidt $any mdefine nil nil)
      ($mat)
    (declare (special $mat))
    ((lambda ($orto $mat_size $vk $acum)
       (declare (special $acum $vk $mat_size $orto))
       (cond
        ((not (like (marrayref $mat_size 1.) (marrayref $mat_size 2.)))
         (simplify ($error "`mat` must be square."))))
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
           (setq $vk (simplify ($mextra_col $mat $i))))
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
                                     (simplify ($mextra_col $orto $j)))
                             (simplify
                              ($mextra_mod (simplify ($mextra_col $orto $j)))))
                            (simplify ($mextra_col $orto $j)))))))
         (simplify ($mextra_set_column $orto $i (add* $vk (*mminus $acum)))))
       $orto)
     (simplify ($matrix '((mlist))))
     (simplify (mfunction-call $matrix_size $mat)) '((mlist)) 0.0)
    ))
(let ()
  (declare (special $mextra_access_p))
  (if (not (boundp '$mextra_access_p)) (add2lnc '$mextra_access_p $values))
  (defparameter $mextra_access_p t))
