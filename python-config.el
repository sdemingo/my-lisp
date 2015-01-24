
;;
;; Configuración del modo Python
;;


(setq syscmd-python-run-command "python")


(defun python-run-file ()
  "Ejecuta python usando el comando guardado en syscmd-python-run-command"
  (interactive)
  (if (string-match "\\.py$" (buffer-file-name))
      (shell-command (concat syscmd-python-run-command " " (buffer-file-name)))))




;; Redefino keybindings para el modo python
(add-hook 'python-mode-hook '(lambda ()
			       (local-set-key (kbd "C-c C-c") 'python-run-file)
			       ))

;; Redefino el comando python para que me abra la consola de python3 como intérprete
(setq python-python-command "python")


;; Autocompletado con jedi
;(autoload 'jedi:setup "jedi" nil t) 

;(require 'jedi)
;(add-hook 'python-mode-hook 'jedi:setup)
;(setq jedi:server-command (list "python3" jedi:server-script))
;(jedi-mode 1)
;(setq jedi:complete-on-dot t)
