

;;
;; Configuración de Dired
;;


(require 'dired-x)
(setq dired-omit-files "^\\...+$")
(add-hook 'dired-mode-hook (lambda () (dired-omit-mode 1)))


;; Borrado y copia recursiva
(setq dired-recursive-deletes 'always)
(setq dired-recursive-copies 'always)



(setq dired-dwim-target t)


(setq delete-by-moving-to-trash t
      trash-directory "~/Escritorio/trash")



;; Abrir ficheros con aplicaciones externas
(defun dired-open-dir-native ()
  "Open the current file in desktop.
Works in Microsoft Windows, Mac OS X, Linux."
  (interactive)
  (shell-command (concat syscmd-file-open " " ".")))



(defun dired-open-file-native ()
  "Open marked files (or the file the cursor is on) from dired."
  (interactive)
  (let* ((files (dired-get-marked-files t current-prefix-arg))
	 (n (length files)))
    (when (or (<= n 3)
	      (y-or-n-p (format "Open %d files?" n)))
      (dolist (file files)
	(call-process syscmd-file-open nil 0 nil file)))))


(defun dired-open-buffer-native ()
  "Open current buffer in a native application"
  (interactive)
  (call-process syscmd-file-open nil 0 nil (buffer-name)))


