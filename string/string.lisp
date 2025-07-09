;; Copyright (C) BY-NC 2025 - Yassin Achengli <achengli@github.com>
;; ---
;; This library is unded BSD clause 3 license.
;; If you don't want to get notifications every time you load this library, setup 
;; `string-lisp-notification-enabled' variable to nil.

(require :asdf)

;; quicklisp cl-ppcre dependency
(if (functionp 'ql:quickload)
  (ql:quickload :cl-ppcre :silent t)
  (require :cl-ppcre))

;; On startup notifications
(if (boundp 'string-lisp-notification-enabled)
  (print "string.lisp is depending on cl-ppcre and quicklisp."))

(defmacro kat (&rest p)
  `(print (list ,@p)))

(defmacro split (s separator)
  `(uiop:split-string ,s :separator ,separator))

;; Get string slices from a string divided by `separator'."
(defun $strsplit (str sep)
  (let ((s (split str sep)))
    (append '((mlist)) s)))

;; Remove `sep' in beginning and end from `str'
;; If `sep' is not defined, sep will be set to blank space character.
(defun $trim (str &optional sep)
  (string-trim (if sep sep " ") str))

;; TODO: use 'string-capitalize instead this bunch of code.
(defun $capitalize (str)
  (let ((words (split str " ")) 
        (capital ""))
    (loop for word in words do
          (setq capital 
                (concatenate 'string capital " " 
                             (concatenate 'string 
                                          (string 
                                            (char-upcase
                                              (char word 0)))
                                          (subseq word 1))))) (string-trim " " capital)))

(defun $rsplit (str sep)
  (let ((s (split str sep)))
    (append '((mlist)) (reverse s))))

(defun $find (str pattern)
  (if (cl-ppcre:scan-to-strings pattern str)
    t nil))

;; Convert lisp function to maxima function using `maxima-function' name in maxima. 
(defmacro lisp-to-maxima-function (maxima-function lisp-function &rest params)
  `(defun ,(intern (concatenate 'string "$" (symbol-name maxima-function)))
     ,params
     (apply #',lisp-function (list ,@params))))

(lisp-to-maxima-function upcase string-upcase str)
(lisp-to-maxima-function downcase string-downcase str)
(lisp-to-maxima-function rstr reverse str)

;; end of string.lisp
