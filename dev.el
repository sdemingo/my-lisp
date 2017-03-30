
;;
;; Modulo para programación en general
;;


;; Extensiones para entorno java

(setq java-files '(
		   ".+\\.java$"
		   ".+\\.jsp$"
		   "+.\\.gsp$"
		   ".+build.xml$"
		   ))


;; Tabular un buffer entero
(defun indent-whole-buffer ()
  "Indent whole buffer"
  (interactive)
  (save-excursion (indent-region (point-min) (point-max) nil)))


;; Función para encontrar el fichero de construcción (makefile o build.xml) 
;; el os directorios superiores
(defun get-above-build-file (mkfile)
  (expand-file-name mkfile
		    (loop as d = default-directory then (expand-file-name ".." d)
			  if (file-exists-p (expand-file-name mkfile d))
			  return d)))


;; Determina si estamos en un entorno java
(defun is-java-compile-mode ()
  (interactive)
  (let ((list java-files)
	(e nil)
	(ret nil))
    (while list
      (setq e (car list))
      (if (string-match e buffer-file-name)
	  (setq ret t))
      (setq list (cdr list)))
    (setq v ret)
    )
  )



;; Función para compilar un projecto usando el fichero de construcción 
;; adecuado según estemos en un entorno java o no
(defun compile-ant-or-make()
  (interactive)
  (if (is-java-compile-mode)
      (compile (format "ant -f %s" (get-above-build-file "build.xml")))
    (compile (format "make -f %s" (get-above-build-file "makefile")))))


;; Evita pulsar el intro cada vez que introducimos la tecla de compilar
(setq compilation-read-command nil)


;; Gestion del buffer de compilación:
;;   -  Crea una ventana aparte para el buffer de compilación
;;   -  http://stackoverflow.com/questions/745694/how-can-i-make-the-compilation-log-create-a-new-window-in-emacs/746071#746071
(setq special-display-buffer-names
      `(("*compilation*" . ((name . "*compilation*")
			    ,@default-frame-alist
			    (width . 80) 
			    (height . 40)
			    (left . (- 1))
			    (top . 0)))))


; (add-to-list 'default-frame-alist '(fullscreen . maximized))


;;   - Autocerrado de la ventana de compilación
;;   - http://www.emacswiki.org/emacs/ModeCompile (casi al final de la página)
;; (defun compile-autoclose (buffer string)
;;   (cond ((string-match "finished" string)
;; 	 (message "Build maybe successful: closing window.")
;; 	 (run-with-timer 1 nil
;; 			 'quit-window
;; 			 (get-buffer-window buffer t)))
;; 	(t
;; 	 (message "Compilation exited abnormally: %s" string))))


;; Funciones para generar metodos getter y setter para java
(defun append-getter-setter-methods (atribute type)
  (insert (format "\tpublic %s get%s(){\n\t}\n\n" type (capitalize atribute)))
  (insert (format "\tpublic void set%s(%s %s){\n\t}"
		  (capitalize atribute) type atribute)))



(defun write-getter-setter-methods ()
  (interactive)
  (setq att (read-string "Field class name: "))
  (setq typ (read-string "Type of field: "))
  (append-getter-setter-methods att typ))


(defun java-simple-compile-run ()
  (interactive)
  (if (string-match "\\.java$" (buffer-file-name))
      (progn 
	(shell-command (concat "javac " (buffer-file-name)))
	(shell-command
	 (concat "java "
		 (file-name-sans-extension
		  (file-name-nondirectory (buffer-file-name)))))
	)))


(defun java-simple-compile ()
  (interactive)
  (if (string-match "\\.java$" (buffer-file-name))
      (shell-command (concat "javac " (file-name-nondirectory (buffer-file-name))))
    ))



;;
;; Configuración del web-mode (http://web-mode.org/)
;;

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

(setq web-mode-markup-indent-offset 2)
(setq web-mode-css-indent-offset 2)
(setq web-mode-code-indent-offset 2)





;;
;;   Hooks
;;

;; Asociamos el modo c++ a los ficheros .b de limbo
(setq auto-mode-alist (append '(("\\.b$" . c++-mode)) auto-mode-alist))

;; Asocio el nxml-mode a fichero jsp
(setq auto-mode-alist (append '(("\\.jsp$" . nxml-mode)) auto-mode-alist))

;; Asocio el nxml-mode a fichero gsp (grails)
(add-to-list 'auto-mode-alist '("\.gsp$" . nxml-mode))


;; Asociamos la función de autocerrado del buffer de compilación
;(setq compilation-finish-functions 'compile-autoclose)



;; CSS and Rainbow modes 
(require 'rainbow-mode)
(defun all-css-modes() (css-mode) (rainbow-mode))
(add-to-list 'auto-mode-alist '("\\.css$" . all-css-modes))



(defun visit-term-buffer ()
  "Create or visit a terminal buffer in a splitted window."
  (interactive)
  (if (not (get-buffer "*ansi-term*"))
      (progn
	(split-window-sensibly (selected-window))
	(other-window 1)
	(ansi-term (getenv "SHELL")))
    (switch-to-buffer-other-window "*ansi-term*")))



;;
;; (Deprecated)
;;
;; ;; Función para encontrar el makefile en el fichero padre
;; (defun get-above-makefile ()
;;   (expand-file-name "makefile"
;; 		    (loop as d = default-directory then (expand-file-name ".." d)
;; 			  if (file-exists-p (expand-file-name "makefile" d))
;; 			  return d)))


;; ;; Función para encontrar el build.xml en el fichero padre
;; (defun get-above-build ()
;;   (expand-file-name "build.xml"
;; 		    (loop as d = default-directory then (expand-file-name ".." d)
;; 			  if (file-exists-p (expand-file-name "build.xml" d))
;; 			  return d)))



;; 
;; Reemplaza <,> y & por sus HTML entities. Código escrito por Xah Lee
;; en http://ergoemacs.org/emacs/elisp_replace_html_entities_command.html
;;
(defun html-replace-html-chars-to-entities (*begin *end &optional *entity-to-char-p)
  "Replace HTML chars & < > to HTML entities on current line or selection.
The string replaced are:
 & ⇒ &amp;
 < ⇒ &lt;
 > ⇒ &gt;

Print to message buffer occurrences of replacement (if any), with position.
If `universal-argument' is called, the replacement direction is reversed.
When called in lisp code, *begin *end are region begin/end positions. If entity-to-char-p is true, change entities to chars instead.
See also: `xah-html-replace-html-named-entities', `xah-html-replace-html-chars-to-unicode'
URL `http://ergoemacs.org/emacs/elisp_replace_html_entities_command.html'
Version 2016-09-02"
  (interactive
   (list
    ;; These are done separately here
    ;; so that command-history will record these expressions
    ;; rather than the values they had this time.
    ;; 2016-07-06 note, if you add a else, it won't work
    (if (use-region-p) (region-beginning))
    (if (use-region-p) (region-end))
    (if current-prefix-arg t nil)))

  (if (null *begin) (setq *begin (line-beginning-position)))
  (if (null *end) (setq *end (line-end-position)))

  (let ((-changedItems '())
        (-findReplaceMap
         (if *entity-to-char-p
             ;; this to prevent creating a replacement sequence out of blue
             [
              ["&amp;" "&"] ["&lt;" "<"] ["&gt;" ">"]
              ["&" "&"] ["<" "<"] [">" ">"]
              ]
           [ ["&" "&amp;"] ["<" "&lt;"] [">" "&gt;"] ]
           )))
    (save-excursion
      (save-restriction
        (narrow-to-region *begin *end)
        (let ( (case-fold-search nil))
          (mapc
           (lambda (-x)
             (goto-char (point-min))
             (while (search-forward (elt -x 0) nil t)
               (push (format "%s %s" (point) -x) -changedItems)
               (replace-match (elt -x 1) "FIXEDCASE" "LITERAL")))
           -findReplaceMap))))
    (mapcar
     (lambda (-x) (princ -x) (terpri))
     (reverse -changedItems))))
