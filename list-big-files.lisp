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

(defun good-printing (lst)
  "Good printing for the list of list, the nested list have the filepath and the size."
  (if (equal nil lst)
      nil
      (progn
	(format t "~A ~A~%" (first (car lst)) (second (car lst)))
	(good-printing (cdr lst)))))

(defun list-big-files (filepath)
  "Check if the input is a file or a directory, return the list of files ordered by size."
  (if (directory-p filepath)
      (progn
	(setf *dir* nil)
	(walker filepath)
	(let ((sorted-filepaths (sort *dir* #'> :key #'second)))
	  (good-printing sorted-filepaths)))
      (format t "~A ~A" filepath (size-file filepath))))
