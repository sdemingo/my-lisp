
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
	 "/apps/w3m" ";"
	 (getenv "PATH")
	 )
	)

;(setq exec-path (append (getenv "PATH")))

;; reconfiguro la fuente de letra para Windows
(set-face-attribute 'default nil :family "Consolas" :height 120)

;; Reconfiguro las variables de comando de sistema
(setq syscmd-file-open "explorer")   ;;de defuns.el
(setq syscmd-python-run-command "python")  ;;de python-config.el



(global-set-key (kbd "<f7>")
                (lambda () (interactive)
		  (shell)))

