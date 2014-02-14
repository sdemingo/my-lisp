
;;
;;   Configuración de Org-mode
;;


(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

(setq org-agenda-ndays '28)
(setq org-log-done 'time)


(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)
(setq org-clock-persist t)



(custom-set-faces
 '(org-agenda-date ((t (:foreground "CornflowerBlue" :weight bold))) t)
 '(org-agenda-date-weekend ((t (:foreground "ForestGreen" :weight bold))) t)
 '(org-date ((t (:foreground "ForestGreen" :weight normal :underline t))) t)
 '(org-level-1 ((t (:foreground "DeepSkyBlue3" :weight bold))) t)
 '(org-level-3 ((t (:foreground "LightBlue2" :weight normal))) t)
 '(org-todo ((t (:foreground "brown2" :weight bold))) t)
 '(org-done ((t (:foreground "green" :weight bold)))))


(setq org-agenda-files
      (file-expand-wildcards "~/.emacs.d/org-agenda/*.org"))

(setq org-src-preserve-indentation t)


(setq org-agenda-custom-commands
      `(
	;; Comandos para casa

	("p" agenda "Agenda Personal"
	 ((org-agenda-ndays 28)
	  (org-agenda-filter-preset '("-aula"))
	  ))
	("c" "Tareas personales para casa" tags-todo "personal|code")

	;; Comandos para el instituto
	("A" agenda "Agenda de Aula"
	 ((org-agenda-ndays 14)
	  (org-agenda-filter-preset '("+aula"))
	  ))
	("I" "Tareas del Instituto" tags-todo "ies")
	))




(eval-after-load "org-agenda"
  '(defun org-encode-for-stdout (s) s))
