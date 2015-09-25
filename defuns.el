
;;
;; Configuración del funciones y variables genéricas
;;



;; Comandos de sistema
(setq syscmd-latex-compile "pdflatex")
(setq syscmd-latex-preview "evince")
(setq syscmd-file-open "xdg-open")
(setenv "PYTHONPATH" "/usr/local/lib/python2.7/dist-packages:/home/sdemingo/.emacs.d/elpa/jedi-0.1.2")



;;     Carga el PATH aun cuando arranque desde el entorno gráfico
(defun set-exec-path-from-shell-PATH ()
  "Carga el PATH aun cuando arranque desde el entorno gráfico"
  (let ((path-from-shell (replace-regexp-in-string
			  "[ \t\n]*$"
			  ""
			  (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))




;; Tema

;; Parámetros independientes de los colores: barras, cursor, menus,
;; etc.
(setq default-frame-alist
      '(
	(cursor-type . box)
	(scroll-bar-width . 20)
	))

;; Colores
(defun set-dark-colors ()
  (interactive)
  (set-background-color "grey5")
  (set-foreground-color "white")
  (set-cursor-color "white")
  (set-face-attribute 'default nil :weight 'normal :height 110)
)

(defun set-light-colors ()
  (interactive)
  (set-background-color "wheat1")
  (set-foreground-color "grey5")
  (set-cursor-color "grey5")
  (set-face-attribute 'default nil :weight 'bold :height 140)
)

;; Tipos de letra 
(set-face-attribute 'default nil :family "DejaVu Sans Mono")
(set-face-attribute 'mode-line nil :height 80)  ;; (Solo para la barra de modo)

;; Por defecto el tema oscuro
(set-dark-colors)


;; No scroll bar
(scroll-bar-mode -1)

;; Esconde barra de iconos
(tool-bar-mode -1)

;; Números de línea en la parte izquierda
(global-linum-mode t)


;; copy and paste by classical way
;; (cua-mode t)
;; (setq cua-auto-tabify-rectangles nil) ;; Don't tabify after rectangle commands
;; (transient-mark-mode 1) ;; No region when it is not highlighted
;; (setq cua-keep-region-after-copy t)


;; Configuro resaltado de línea
(global-hl-line-mode 1)

;; Borrar sección de texto al insertar caracter
(delete-selection-mode +1)


;; Uso de UTF-8 por defecto

(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; Resaltado linea actual
'(global-hl-line-mode t nil (hl-line))
'(hl-line-face (quote highlight))


;; Quitamos los pitidos
(setq visible-bell t)

;; Evitar mensaje inicial
(setq inhibit-startup-message t)

;; Iniciar con el menu de bookmarks y la agenda
(require 'bookmark)
(bookmark-bmenu-list)
(switch-to-buffer "*Bookmark List*")  ;; iniciar emacs con bookmarks
(add-hook 'after-init-hook 'org-todo-list)


;; Iniciar maximizado
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Mostrar numero de columna en la barra inferior
(column-number-mode 't)


;; Ordeno resultado de apropos
(setq apropos-sort-by-scores t)

;; Mostrar la ruta del buffer en el título del buffer
;; por Bozhidar Batsov
(setq frame-title-format
      '((:eval (if (buffer-file-name)
		   (abbreviate-file-name (buffer-file-name))
		 "%b"))))


(setq font-lock-maximum-size nil)
(require 'font-lock)
;(require 'lazy-lock)


;; Barra de exploracion
(require 'speedbar)	;; barra antigua
(require 'sr-speedbar)	;; barra en la misma ventana


;; Mata todos los demás buffers menos el activo
(defun kill-other-buffers ()
  "Mata todos los demás buffers menos el activo"
  (interactive)
  (message "killing buffers in background")
  (mapc 'kill-buffer
	(delq (current-buffer)
	      (remove-if-not 'buffer-file-name (buffer-list)))))


(defun display-startup-echo-area-message ()
  (message "   ########   Welcome sdemingo. Let the hacking begin!   ########   "))


;;	Configurar la rueda del raton
;;	por Sylvia Knight (Sylvia.Knight@cl.cam.ac.uk)
(defun up-slightly () (interactive) (scroll-up 5))
(defun down-slightly () (interactive) (scroll-down 5))
(global-set-key [mouse-4] 'down-slightly)
(global-set-key [mouse-5] 'up-slightly)

(defun up-one () (interactive) (scroll-up 1))
(defun down-one () (interactive) (scroll-down 1))
(global-set-key [S-mouse-4] 'down-one)
(global-set-key [S-mouse-5] 'up-one)

(defun up-a-lot () (interactive) (scroll-up))
(defun down-a-lot () (interactive) (scroll-down))
(global-set-key [C-mouse-4] 'down-a-lot)
(global-set-key [C-mouse-5] 'up-a-lot)


;; Carga y configura modo XML
(defun psgml-ext ()
  (setq sgml-set-face t)  
  (setq sgml-markup-faces
	'((comment   . font-lock-comment-face)
	  (start-tag . font-lock-keyword-face)
	  (end-tag   . font-lock-keyword-face)
	  (doctype   . font-lock-builtin-face)
	  (entity    . font-lock-constant-face)))
  )
(setq-default sgml-indent-data t)
(add-hook 'sgml-mode-hook 'psgml-ext)



;; Renombra buffer y fichero al vuelo. De http://emacsredux.com/
(defun rename-file-and-buffer ()
  "Rename the current buffer and file it is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
	(message "Buffer is not visiting a file!")
      (let ((new-name (read-file-name "New name: " filename)))
	(cond
	 ((vc-backend filename) (vc-rename-file filename new-name))
	 (t
	  (rename-file filename new-name t)
	  (set-visited-file-name new-name t t)))))))



;; Reescalado de tamaño de fuente que evita que los números de línea
;; de la izquierda se dejen ver cuando se aumenta el tamaño de texto.
;; Visto en http://unix.stackexchange.com/questions/29786/font-size-issues-with-emacs-in-linum-mode/
;;
;; List: `Sub-Zoom Font Heights per text-scale-mode-step`  
;;   eg.  For a default font-height of 120 just remove the leading `160 150 140 130` 
;; (defvar sub-zoom-ht (list 160 150 140 130 120 120 110 100 100  90  80
;; 80  80  80  70  70  60  60  50  50  50  40  40  40  30  20  20  20  20
;; 20  20  10  10  10  10  10  10  10  10  10  10   5   5   5   5   5   2
;; 2   2   2   2   2   2   2   1   1   1   1   1   1   1   1   1   1   1
;; 1))

;; (setq text-scale-mode-step 1.04)

;; (defvar sub-zoom-ht (list 140 130 120 120 110 100 100  90  80
;; 			  80  80  80  70  70  60  60  50  50  50  40  40  40  30  20  20  20  20
;; 			  20  20  10  10  10  10  10  10  10  10  10  10   5   5   5   5   5   2
;; 			  2   2   2   2   2   2   2   1   1   1   1   1   1   1   1   1   1   1
;; 			  1))

;; (defvar sub-zoom-len (safe-length sub-zoom-ht))
;; (defvar def-zoom-ht (car sub-zoom-ht))
;; (set-face-attribute 'default nil :height def-zoom-ht)

;; (defun text-scale-adjust-zAp ()
;;   (interactive)
;;   (text-scale-adjust 0)
;;   (set-face-attribute 'linum nil :height def-zoom-ht)
;;   )
;; (global-set-key [C-kp-multiply] 'text-scale-adjust-zAp)

;; (defun text-scale-decrease-zAp ()
;;   (interactive)
;;   (if (not (boundp 'text-scale-mode-amount)) ;; first-time init  
;;       (setq  text-scale-mode-amount 0))
;;   (setq text-scale (round (/ (* 1 text-scale-mode-amount) 
;; 			     text-scale-mode-step)))
;;   (if (> text-scale (- 1 sub-zoom-len))
;;       (progn
;; 	(text-scale-decrease text-scale-mode-step)
;; 	(if (<= 0 text-scale-mode-amount)
;; 	    (set-face-attribute 'linum nil :height def-zoom-ht)
;; 	  (if (> 0 text-scale-mode-amount)
;; 	      (set-face-attribute 'linum nil :height 
;; 				  (elt sub-zoom-ht (- 0 text-scale)))))))
;;   )


;; (defun text-scale-increase-zAp ()
;;   (interactive)
;;   (if (not (boundp 'text-scale-mode-amount)) ;; first-time init  
;;       (setq  text-scale-mode-amount 0))
;;   (setq text-scale (round (/ (* 1 text-scale-mode-amount) 
;; 			     text-scale-mode-step)))
;;   (if (< text-scale 85)
;;       (progn
;; 	(text-scale-increase text-scale-mode-step)
;; 	(if (< (- 0 text-scale-mode-step) text-scale-mode-amount)
;; 	    (set-face-attribute 'linum nil :height def-zoom-ht)
;; 	  (if (> 0 text-scale-mode-amount)
;; 	      (set-face-attribute 'linum nil :height 
;; 				  (elt sub-zoom-ht (- 0 text-scale)))))))
;;   )


