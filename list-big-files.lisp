(ql:quickload '(:osicat :uiop :cl-fad))

(defparameter *dir* nil
  "All file paths")

(defun size-file (filepath)
  "For some `filepath' return the size."
  (let ((stat (osicat-posix:stat filepath)))
    (osicat-posix:stat-size stat)))

(defun directory-p (filepath)
  "Is a directory?"
  (if (cl-fad:directory-exists-p filepath)
      t
      nil))

(defun walker (filepath)
  "List the files and directories of a directory, recursively."
  (cl-fad:walk-directory filepath
			 (lambda (file)
			   (push (list (format nil "~A" file) (size-file file)) *dir*))
			 :directories t))

(defun list-big-files (filepath)
  "Check if the input is a file or a directory, return the list of files ordered by size."
  (if (directory-p filepath)
      (progn
	(setf *dir* nil)
	(walker filepath)
	(let ((sorted-filepaths (sort *dir* #'> :key #'second)))
	  (mapcar #'(lambda (register)
		      (format nil "~A" (concatenate 'string (first register) " "
						     (write-to-string (second register)))))
		  sorted-filepaths)))
      (format nil "~A ~A" filepath (size-file filepath))))
