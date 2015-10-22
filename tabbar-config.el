

(require 'tabbar)



(tabbar-mode 1)

(defun my-tabbar-buffer-groups () ;; customize to show all normal files in one group
  (list (cond ((string-equal "*" (substring (buffer-name) 0 1)) "emacs")
	      ((eq major-mode 'dired-mode) "emacs")
	      ((eq major-mode 'org-mode) "org")
	      (t "user"))))

(setq tabbar-buffer-groups-function 'my-tabbar-buffer-groups)

(setq tabbar-background-color "grey25") ;; the color of the tabbar background

(custom-set-faces
 '(tabbar-default ((t (:inherit variable-pitch :background "grey25" :foreground "grey80" 
				:weight normal :height 1.5 ))))

 '(tabbar-button ((t (:inherit tabbar-default :foreground "grey25" ))))
 '(tabbar-button-highlight ((t (:inherit tabbar-default))))
 '(tabbar-highlight ((t (:underline t))))
 '(tabbar-selected ((t (:inherit tabbar-default :background "grey40" :weight normal))))

 '(tabbar-separator ((t (:inherit tabbar-default :background "grey25" ))))
 '(tabbar-unselected ((t (:inherit tabbar-default))))
 )


(custom-set-variables
 '(tabbar-separator (quote (2))))
