
;;
;; Funciones de carga de skels y plantillas de código
;;

;; Carga de plantillas
(add-hook 'find-file-hooks 'java-load-skel)
(add-hook 'find-file-hooks 'python-load-skel)
(add-hook 'find-file-hooks 'html-load-skel)
(add-hook 'find-file-hooks 'go-load-skel)
(add-hook 'find-file-hooks 'latex-load-skel)


(defun latex-load-skel ()
  (interactive)
  (when (and
	 (string-match "\\.tex$" (buffer-file-name))
	 (eq 1 (point-max)))
    (insert-file "~/.emacs.d/skels/skel-latex.tex")))


(defun python-load-skel ()
  (interactive)
  (when (and
	 (string-match "\\.py$" (buffer-file-name))
	 (eq 1 (point-max)))
    (insert-file "~/.emacs.d/skels/skel-python.py")))


(defun html-load-skel ()
  (interactive)
  (when (and
	 (string-match "\\.html$" (buffer-file-name))
	 (eq 1 (point-max)))
    (insert-file "~/.emacs.d/skels/skel-web.html")))


(defun java-load-skel ()
  (interactive)
  (when (and
	 (string-match "\\.java$" (buffer-file-name))
	 (eq 1 (point-max)))
    (insert-file "~/.emacs.d/skels/skel-java.java")
    (beginning-of-buffer)
    (replace-string "CLASSNAME" (file-name-sans-extension (file-name-nondirectory (buffer-file-name))))
    ))


(defun go-load-skel ()
  (interactive)
  (when (and
	 (string-match "\\.go$" (buffer-file-name))
	 (eq 1 (point-max)))
    (insert-file "~/.emacs.d/skels/skel-go.go")))
