;;; -*- Mode: Lisp; package:maxima; syntax:common-lisp ;Base: 10 -*- ;;;

; Translated on: 2023-08-01 13:40:09+02:00
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

(simplify ($load "./mextra_matrix.mac"))
(simplify ($load "./mextra_linalg.mac"))