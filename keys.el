
;;
;;  Principales macros de teclas
;;



;; Auto-expansion del texto pulsando control-return
(define-key global-map [(control return)]'dabbrev-expand)

;; Justificación de texto a la izquierda
(define-key global-map [(control l)]'set-justification-left)

;; Poner o quitar regiones de comentarios
(define-key global-map [(control -)]'comment-or-uncomment-region)

;; Añadir identacion a un parrafo
(define-key global-map [C-kp-add] 'increase-left-margin)

;; Eliminar identacion a un parrafo
(define-key global-map [C-kp-subtract] 'decrease-left-margin)

;; Renombrar fichero y buffer
(global-set-key (kbd "C-c r")  'rename-file-and-buffer)

;; Abrir nuevo frame
(global-set-key (kbd "C-c n")  'make-frame)

;; Remapeo la comb del buffer list por el buffer menu
(global-set-key "\C-x\C-b" 'buffer-menu)


;;
;;      Macros para teclas de función
;;
(global-set-key (kbd "<f5>") 'compile-ant-or-make)
(global-set-key (kbd "<f6>") 'compile)
(global-set-key (kbd "<f7>") 'visit-term-buffer)
(global-set-key (kbd "<f8>") 'sr-speedbar-toggle)
(global-set-key (kbd "<f11>") 'org-tags-view)
(global-set-key (kbd "<f12>") 'list-bookmarks)


;;
;;      Macros variadas (C-S-s ...)
;;
;(global-set-key (kbd "C-S-s p") 'sr-speedbar-toggle)
(global-set-key (kbd "C-S-s r") 'recentf-open-files)
(global-set-key (kbd "C-S-s q") 'kill-other-buffers)
(global-set-key (kbd "C-S-s v") 'lorem-in-buffer)
(global-set-key (kbd "C-S-s i") 'indent-whole-buffer)
(global-set-key (kbd "C-S-s t 1") 'set-dark-colors)
(global-set-key (kbd "C-S-s t 2") 'set-light-colors)


;;
;;      Macros para Orgmode
;;
 
(global-set-key (kbd "C-S-o s") 'org-insert-src-block)



;;
;;      Macros para java (C-S-j ...)
;;
(global-set-key (kbd "C-S-j j") 'java-simple-compile-run)
(global-set-key (kbd "C-S-j c") 'java-simple-compile)
(global-set-key (kbd "C-S-j d") 'javadoc-lookup)
(global-set-key (kbd "C-S-j s") 'write-getter-setter-methods)
(global-set-key (kbd "C-S-j TAB") 'jde-complete-menu)

;;
;;      Macros para Go (C-S-g ...)
;;
(global-set-key (kbd "C-S-g d") 'godoc-lookup)
(global-set-key (kbd "C-S-g c") 'go-compile)
(global-set-key (kbd "C-S-g r") 'go-run)



;;
;;      Macros de latex (C-S-l ...)
;;
(global-set-key (kbd "C-S-l l") 'latex-compile)
(global-set-key (kbd "C-S-l v") 'latex-preview)
(global-set-key (kbd "C-S-l c") 'latex-word-count)
(global-set-key (kbd "C-S-l r") 'latex-remove-tmp-files)
(global-set-key (kbd "C-S-l e") 'latex-write-environment)
(global-set-key (kbd "C-S-l t") 'latex-write-slide)
(global-set-key (kbd "C-S-l i") 'latex-write-image)
(global-set-key (kbd "C-S-l k") 'latex-write-code-block)


;;
;;      Macros de jabber (C-S-c ...)
;;
(global-set-key (kbd "C-S-c c") 'jabber-connect-all)
(global-set-key (kbd "C-S-c d") 'jabber-display-roster)



;;
;;      Macros de teclas para el tabbar
;;
(global-set-key (kbd "C-<") 'tabbar-backward)
(global-set-key (kbd "C->") 'tabbar-forward) 



;;
;;      Macros de teclas para dired
;;
(eval-after-load "dired-x"
  '(progn
     ;; Abrir fichero de forma nativa
     (define-key dired-mode-map (kbd "C-o") 'dired-open-file-native)
     (global-set-key (kbd "C-c o")  'dired-buffer-file-native)
     ))

