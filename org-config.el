
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
(setq org-clock-persist nil)

(setq org-list-allow-alphabetical t)



(custom-set-faces
 '(org-agenda-date ((t (:foreground "CornflowerBlue" :weight bold))) t)
 '(org-agenda-date-weekend ((t (:foreground "ForestGreen" :weight bold))) t)
 '(org-date ((t (:foreground "ForestGreen" :weight normal :underline t))) t)
 '(org-level-1 ((t (:foreground "DeepSkyBlue3" :weight bold :height 1.5))) t)
 '(org-level-2 ((t (:foreground "gold" :height 1.3))) t)
 '(org-level-3 ((t (:foreground "LightBlue2" :weight normal))) t)
 '(org-document-title ((t (:foreground "pale turquoise" :weight bold :height 2.0))))
 '(org-todo ((t (:foreground "brown2" :weight bold))) t)
 '(org-done ((t (:foreground "green" :weight bold)))))


(setq org-agenda-files
      (file-expand-wildcards "~/.emacs.d/org-agenda/*.org"))

(setq org-src-preserve-indentation t)


(setq org-agenda-custom-commands
      `(
	;; Comandos para casa

	("a" agenda "Agenda Personal"
	 ((org-agenda-ndays 28)
	  ;(org-agenda-filter-preset '("-astro" "-aula"))
	  (org-agenda-filter-preset '("-astro"))
	  )
	 ;("~/Dropbox/agenda.html")
	 )

	;; ("t" "Cosas Pendientes" tags-todo "-recordatorios" nil)
	;; ("c" "Tareas personales para casa" tags-todo "personal|code" nil ("~/Dropbox/cosas-pendientes.html"))

	("I" "Tareas del Instituto" tags-todo "ies")

	;; ("x" agenda "Efemérides astronómicas"
	;;  ((org-agenda-ndays 28)
	;;   (org-agenda-filter-preset '("+astro" "-aula"))
	;;   ))
	))

(require 'ox-md)


(eval-after-load "org-agenda"
  '(defun org-encode-for-stdout (s) s))


;; Al apagar emacs exportamos la agenda
(add-hook 'kill-emacs-hook 'org-store-agenda-views)


;; Insertar bloques de código en org
(defun org-insert-src-block (src-code-type)
  "Insert a `SRC-CODE-TYPE' type source code block in org-mode."
  (interactive
   (let ((src-code-types
          '("emacs-lisp" "python" "C" "sh" "java" "js" "clojure" "C++" "css"
            "calc" "asymptote" "dot" "gnuplot" "ledger" "lilypond" "mscgen"
            "octave" "oz" "plantuml" "R" "sass" "screen" "sql" "awk" "ditaa"
            "haskell" "latex" "lisp" "matlab" "ocaml" "org" "perl" "ruby"
            "scheme" "sqlite")))
     (list (ido-completing-read "Source code type: " src-code-types))))
  (progn
    (newline-and-indent)
    (insert (format "#+BEGIN_SRC %s\n" src-code-type))
    (newline-and-indent)
    (insert "#+END_SRC\n")
    (previous-line 2)
    (org-edit-src-code)))


;; ditaa
(org-babel-do-load-languages
 'org-babel-load-languages
 '((ditaa . t))) ; this line activates ditaa


;; keybindings solo para el modo
(add-hook 'org-mode-hook '(lambda ()
                            ;; C-TAB for expanding
                            (local-set-key (kbd "C-<tab>")
                                           'yas/expand-from-trigger-key)
                            ;; keybinding for editing source code blocks
                            (local-set-key (kbd "C-c s e")
                                           'org-edit-src-code)
                            ;; keybinding for inserting code blocks
                            (local-set-key (kbd "C-c s i")
                                           'org-insert-src-block)
                            ))



