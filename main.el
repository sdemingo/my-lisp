
;;
;; Fichero principal
;;
;; Carga de módulos y ficheros de configuración
;;


;;      Configuro mi directorio de paquetes
(add-to-list 'load-path "~/.emacs.d/lisp")
(add-to-list 'load-path "~/.emacs.d/lisp/modules/")
(add-to-list 'load-path "~/.emacs.d/lisp/modules/auto-complete")
(add-to-list 'load-path "~/.emacs.d/lisp/modules/go-mode")
(add-to-list 'load-path "~/.emacs.d/lisp/modules/javadoc-lookup")
(add-to-list 'load-path "~/.emacs.d/lisp/modules/emacs-web-server")
(add-to-list 'load-path "~/.emacs.d/lisp/elpa/")
(add-to-list 'load-path "~/.emacs.d/lisp/elpa/jedi-0.1.2")
(add-to-list 'load-path "~/.emacs.d/lisp/elpa/epc-0.1.1")
(add-to-list 'load-path "~/.emacs.d/lisp/elpa/concurrent-0.3.1")
(add-to-list 'load-path "~/.emacs.d/lisp/elpa/deferred-0.3.1")
(add-to-list 'load-path "~/.emacs.d/lisp/elpa/ctable-0.1.1")
(add-to-list 'load-path "~/.emacs.d/lisp/elpa/tabbar-20141109.143")
(add-to-list 'load-path "~/.emacs.d/lisp/elpa/undo-tree-20140509.522")
(add-to-list 'load-path "~/.emacs.d/lisp/modules/org-8.2.6/lisp")  ;;lastest orgmode version
(add-to-list 'load-path "~/.emacs.d/lisp/modules/org-8.2.6/contrib/lisp" t)

;; Fichero de funciones de personalización
(load "~/.emacs.d/my-lisp/defuns.el")

;; Fichero de configuración de org
(load "~/.emacs.d/my-lisp/org-config.el")

;; Fichero de configuración para carga de skels
(load "~/.emacs.d/my-lisp/skels.el")

;; Fichero de configuración para modos Java y C
(load "~/.emacs.d/my-lisp/dev.el")

;; Fichero de configuración para modos Text y LaTeX
(load "~/.emacs.d/my-lisp/latex.el")

;; Fichero de configuración de slime y lisp
;; (load "~/.emacs.d/lisp/modules/slime-lisp.el")

;; Fichero de configuración de ispell
(load "~/.emacs.d/my-lisp/ispell-config.el")

;; Fichero de configuración del autosave
(load "~/.emacs.d/my-lisp/auto-save.el")

;; Fichero de configuración de la lista de recientes
(load "~/.emacs.d/my-lisp/recent-files.el")

;; Fichero de configuración del autocomplete
(load "~/.emacs.d/my-lisp/auto-complete-init.el")

;; Búsqueda de info en javadoc
(load "~/.emacs.d/lisp/modules/javadoc-lookup/javadoc-lookup.el")

;; Módulo lorem-ipsum
(load "~/.emacs.d/lisp/modules/lorem-ipsum.el")

;; Fichero de configuración del modulo de GO
(load "~/.emacs.d/my-lisp/go-mode-config.el")

;; Fichero de configuración del modulo de Python
(load "~/.emacs.d/my-lisp/python-config.el")

;; Fichero de configuración de dired
(load "~/.emacs.d/my-lisp/dired-config.el")

;; Fichero de keybindings
(load "~/.emacs.d/my-lisp/keys.el")

;; Fichero de easypg
(load "~/.emacs.d/my-lisp/easypg-config.el")

;; Fichero de configuración de Markdown mode 
(load "~/.emacs.d/my-lisp/markdown-mode-config.el")

;; Htmlize
(load "~/.emacs.d/lisp/modules/htmlize.el")

;; Linum-off
(load "~/.emacs.d/lisp/modules/linum-off.el")

;; Configuración de bookmarks
(load "~/.emacs.d/my-lisp/bookmarks-config.el")

;; Configuración de bookmarks
(load "~/.emacs.d/my-lisp/tabbar-config.el")

;; Configuración de undo tree
(load "~/.emacs.d/my-lisp/undo-tree-config.el")



;; Fichero de carga para la versión portable y de windows
(if (eq system-type 'windows-nt)
    (load "~/.emacs.d/my-lisp/port-windows.el"))

;; Fichero de w3m
;; (load "~/.emacs.d/my-lisp/w3m-config.el")



;;     Cargo mi PATH aun cuando arranque desde el entorno gráfico
;;     siempre y cuando no estemos en windows
(if (not (eq system-type 'windows-nt))
    (if window-system (set-exec-path-from-shell-PATH))
)


;; (load (expand-file-name "~/.quicklisp/slime-helper.el"))
;; (setq inferior-lisp-program "sbcl")


;; Configuración para instalar paquetes directamente desde
;; marmalade. Se necesita instalar package.el de la página oficial de
;; marmlade

(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  ;(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
  (setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
  			   ("melpa" . "http://melpa.milkbox.net/packages/")
  			   ("marmalade" . "http://marmalade-repo.org/packages/")))
)
  
