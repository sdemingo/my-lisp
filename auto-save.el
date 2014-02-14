
;;
;;      Configuración de los ficheros de autosalvados y backups 
;;      bajo .emacs-local en cada máquina 
;;

(make-directory "~/.emacs-local/autosaves/" t)
(make-directory "~/.emacs-local/backups/" t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-file-name-transforms (quote ((".*" "~/.emacs-local/autosaves/\\1" t))))
 '(backup-directory-alist (quote ((".*" . "~/.emacs-local/backups/"))))
 '(case-fold-search t)


 '(speedbar-supported-extension-expressions (quote (".[ch]\\(\\+\\+\\|pp\\|c\\|h\\|xx\\)?" ".tex\\(i\\(nfo\\)?\\)?" ".el" ".emacs" ".l" ".lsp" ".p" ".java" ".f\\(90\\|77\\|or\\)?" ".ada" ".p[lm]" ".tcl" ".m" ".scm" ".pm" ".py" ".g" ".s?html" "[Mm]akefile\\(\\.in\\)?" ".txt"))))

