(ql:quickload '(:osicat :uiop :cl-fad))

(defparameter *dir* nil
  "All the directories")

(defun size-file (filepath)
  "For some `filepath' return the size."
  (let ((stat (osicat-posix:stat filepath)))
    (osicat-posix:stat-size stat)))

(defun walker (filepath)
  "List the files and directories of a directory, recursively."
  (cl-fad:walk-directory filepath
			 (lambda (file)
			   (push (list (format nil "~A" file) (size-file file)) *dir*))
			 :directories t))

(defun list-major-files (filepath)
  "Return a list of list files and filesize."
  (progn
    (walker filepath)
    (sort *dir* #'> :key #'second)))
