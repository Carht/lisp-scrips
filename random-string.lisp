;; Generate random string in CL

(defparameter *characters*
  (concatenate 'string
	       "abcdefghijklmnopqrstuvwxyz"
	       "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	       "0123456789"))

(defparameter *nums* "0123456789")

(defun random-element (lst)
  (aref lst (random (length lst))))

(defun random-string (length-characters)
  (if (zerop length-characters)
      nil
      (cons (random-element *characters*)
	    (random-string (1- length-characters)))))

(defun random-num (length-nums)
  (if (zerop length-nums)
      nil
      (cons (random-element *nums*)
	    (random-num (1- length-nums)))))

(defun rand-str (length-chars)
  (let ((list-of-random-chars (random-string length-chars)))
    (concatenate 'string list-of-random-chars)))

(defun rand-nums (length-nums)
  (let ((list-of-random-nums (random-num length-nums)))
    (concatenate 'string list-of-random-nums)))
