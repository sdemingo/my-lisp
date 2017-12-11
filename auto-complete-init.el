
;;
;; Configuración del módulo de autocompletado
;;

(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "/home/sdemingo/.emacs.d/lisp/modules/auto-complete/ac-dict")
(ac-config-default)


(load "~/.emacs.d/lisp/modules/auto-complete/auto-complete-latex.el")
(add-to-list 'ac-modes 'go-mode)
(add-to-list 'ac-modes 'web-mode)
