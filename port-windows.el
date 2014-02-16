
;;
;; Configuración especifica para emacs portable sobre windows
;;


;; Configuro mi PATH añiendo las rutas de las portable apps 
(setenv "PATH"
	(concat
	 "/apps/miktex/miktex/bin" ";"
	 "/apps/Java/bin" ";"
	 "/apps/Portable Python 3.2.5.1/App" ";"
	 "/apps/strawberry/perl/bin" ";"
	 "/apps/cygwin/bin" ";"
	 (getenv "PATH")
	 )
	)

(setq exec-path (append (getenv "PATH")))

;(setq w3m-command "/cygdrive/e/apps/cygwin/bin/w3m.exe")

;; Reconfiguro las variables de comando de sistema
(setq syscmd-file-open "explorer")   ;;de defuns.el
(setq syscmd-python-run-command "python")  ;;de python-config.el


(global-set-key (kbd "<f7>")
                (lambda () (interactive)
		  (shell)))

