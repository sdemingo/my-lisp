
;;
;; Configuro lista de archivos recientes
;;
(require 'recentf)

(setq recentf-save-file "~/.emacs-local/recentf")
(recentf-mode 1)
(setq recentf-max-menu-items 25)

(recentf-load-list)

