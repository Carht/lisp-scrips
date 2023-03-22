(ql:quickload '(:osicat :uiop :cl-fad))

(defun directory-p (filepath)
  "Is a directory?"
  (if (cl-fad:directory-exists-p filepath)
      t
      nil))

(defparameter *dir* nil
  "Path of files in a directory")

(defmacro clean-file (filepath)
  "Create a process-info object and call the command shred for the file."
  `(defparameter *clean* (uiop:wait-process
			  (uiop:launch-program
			   (concatenate 'string "/usr/bin/shred -u -n 5 "
					,filepath)))))

(defun walker (filepath)
  "Return a list of files and subdirectories of a directory, recursively."
  (cl-fad:walk-directory filepath
			 (lambda (file)
			   (push (format nil "~A" file) *dir*))
			 :directories t))

(defun clean-files (list-of-files)
  "Clean the files of the walker path."
  (mapcar #'(lambda (file)
	      (if (directory-p file)
		  (format t "Directory: ~A~%" file)
		  (progn
		    (format t "Cleaning file: ~A~%" file)
		    (clean-file file))))
	  list-of-files))

(defun secure-delete (filepath)
  "If `filepath' is a directory, apply clean over all sub directories. If `filepath' is not
a directory, clean the file, securely."
  (let ((is-dir? (directory-p filepath)))
    (if is-dir?
	(progn
	  (walker filepath)
	  (clean-files *dir*))
	(clean-file filepath))))
