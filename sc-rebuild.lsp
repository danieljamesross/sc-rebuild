(require 'uiop)

(defun rm-fasl-files (sc-bin &key cmn-bin clm-bin simulate)
  "Remove .fasl files from slippery chicken, CMN and CLM-5 folders"
  (let ((dir-list (list sc-bin)))
    (when cmn-bin (push cmn-bin dir-list))
    (when clm-bin (push clm-bin dir-list))
    (loop for dir in (reverse dir-list)
	  with ok = '()
	  with wild-dir do
	    (setf dir (uiop:native-namestring dir))
	    (if (not (probe-file dir))
		(error "~%sc-rebuild: ~a is not a valid directory" dir)
		(setf wild-dir
		      (make-pathname :directory
				     (list :absolute dir)
				     :name :wild :type "fasl")))
	    (loop for file in (directory wild-dir)
		  with count = 0 do
		    (unless simulate
		      (delete-file file)
		      (incf count))
		  finally
		     (return
		       (format t "~%Deleted ~a files in ~a" count dir)))
	    (push dir ok)
	    ;; return list of directories
	  finally (return (reverse ok)))))

(defun brew-install-sbcl ()
  "Install SBCL to latest version"
  (format t "Initialising...")
  (uiop:run-program "brew upgrade sbcl" :output :string))

(defun sc-rebuild  (sc-bin &key cmn-bin clm-bin simulate)
  (brew-install-sbcl)
  (rm-fasl-files :sc-bin sc-bin
		 :cmn-bin cmn-bin
		 :clm-bin clm-bin
		 :simulate simulate))

;; (rm-fasl-files "~/sc/bin"
;; 	       :cmn-bin "~/lisp/cmn"
;; 	       :clm-bin "~/lisp/clm-5"
;; 	       :simulate nil)
