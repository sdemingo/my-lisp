

;;; From http://nflath.com/2009/09/web-browsing-in-emacs/comment-page-1/

(require 'w3m)
(require 'w3m-session)
(require 'w3m-cookie)



(defun my-w3m-rename-buffer (url)
  "Renames the current buffer to be the current URL"
  (rename-buffer url t))
(add-hook 'w3m-display-hook 'my-w3m-rename-buffer)
 
(add-hook 'w3m-display-hook
          (lambda (url)
            (let ((buffer-read-only nil))
              (delete-trailing-whitespace))))


(defun w3m-browse-current-buffer ()
  "Look at the current buffer as rendered by w3m."
  (interactive)
  (let ((filename (concat (make-temp-file "w3m-") ".html")))
    (unwind-protect
        (progn
          (write-region (point-min) (point-max) filename)
          (w3m-find-file filename))
      (delete-file filename))))


(setq w3m-session-file "~/.emacs.d/.w3m-session")
(setq w3m-session-autosave t)
(setq w3m-session-load-last-sessions t)
(setq w3m-use-cookies t)
(setq browse-url-browser-function 'w3m-browse-url)
(setq browse-url-new-window-flag t)
(setq w3m-default-display-inline-images t)
(setq w3m-fill-column 80)


(unless window-system
  (setq browse-url-browser-function 'w3m-browse-url)
  (setq browse-url-new-window-flag t))
