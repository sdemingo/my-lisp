
;;
;;  Configuración del modo de Texto y Latex
;;

(add-hook 'text-mode-hook '(lambda ()
			     (setq word-wrap t)))

(add-hook 'text-mode-hook 'turn-on-auto-fill)
(add-hook 'text-mode-hook '(lambda()
			     (set-fill-column 80)))



;; Extensiones de ficheros temporales que crea
;; la compilación de latex
(setq latex-tmp-files-list
	(list
	 ".aux"
	 ".log"
	 ".bbl"
	 ".bbg"
))


(add-hook 'latex-mode-hook '(lambda ()
			      (setq word-wrap t)))
(add-hook 'latex-mode-hook 'turn-on-auto-fill)
(add-hook 'latex-mode-hook '(lambda()
			      (set-fill-column 80)))
(add-hook 'find-file-hooks 'latex-load-skel)
(add-hook 'latex-mode-hook '(lambda ()
			      (setq font-lock-keywords-only t)))



(defun latex-compile ()
  "Compila latex usando el comando guardado en syscmd-latex-compile"
  (interactive)
  (if (string-match "\\.tex$" (buffer-file-name))
      (shell-command (concat syscmd-latex-compile " " (buffer-file-name)))))



(defun latex-preview ()
  "Previsualiza un PDF. No funciona en windows"
  (interactive)
  (setq file (concat (file-name-sans-extension buffer-file-name) ".pdf"))
  (call-process syscmd-file-open nil 0 nil file))



;; (No funciona con del en windows por los slash de la ruta)
(defun latex-remove-tmp-files()
  "Limpia ficheros temporales creados por la compilación de latex
  y guardados en la lista latex-tmp-files-list"
  (interactive)
  (let ((list latex-tmp-files-list))
    (while list
      (setq ext (car list))
      (dired-delete-file (concat (file-name-sans-extension buffer-file-name) ext))
      (setq list (cdr list)))))


(defun latex-word-count ()
  "Muestra las estadísticas de un fichero latex usando texcount"
  (interactive)
  (shell-command (concat "texcount " buffer-file-name)))


;; no funciona en entornos anidados
(defun latex-write-environment ()
  "Genera el código de un entorno tras pedirnos el nombre de este"
  (interactive)
  (setq env (read-string "Name of the environment: "))
  (insert (format "\\begin{%s}\n\n\n\\end{%s}\n" env env))
  (search-backward "\n\n"))


(defun latex-write-slide ()
  "Genera el código de una diapositiva"
  (interactive)
  (setq title (read-string "Title: "))
  (insert (format "\\begin{frame}\n\\frametitle{%s}\n\\begin{itemize}\\setlength{\\itemsep}{0.6cm}\n\\item \n\\end{itemize}\n\\end{frame}\n" title))
  (search-backward "item ")
  (move-end-of-line nil))

(defun latex-write-image ()
  "Genera el código de un entorno tras pedirnos el nombre de este"
  (interactive)
  (setq path (read-string "Image path: "))
  (insert (format "\\begin{figure}\n\\includegraphics[scale=0.5]{%s}\n\\end{figure}\n" path)))


(defun latex-write-code-block ()
  "Genera el código de un entorno de código para docencia"
  (interactive)
  (setq width (read-string "Block width: "))
  (insert (format "\\codigo{%s}{\n\n\n}\n" width))
  (search-backward "\n\n"))




;;
;;  Para exportar bufferes y regiones en LaTeX a HTML
;;


(defun latex-export-region-to-html()
  (interactive)

  (clipboard-kill-ring-save (point-min) (point-max))
  (set-buffer (get-buffer-create "html-content"))
  (erase-buffer)
  (clipboard-yank)
  (switch-to-buffer "html-content")

  (clear-regexp "\\\\setlength{\\\\itemsep}{.*}")
  (clear-regexp "\\\\label{.*}")

  (sustitute-simple-cmd "\\item" "<li>")
  (sustitute-simple-cmd "\\begin{enumerate}" "<ol>")
  (sustitute-simple-cmd "\\end{enumerate}" "</ol>")
  (sustitute-simple-cmd "\\begin{itemize}" "<ul>")
  (sustitute-simple-cmd "\\end{itemize}" "</ul>")

  (sustitute-pre-content-cmd "bf" "b")
  (sustitute-pre-content-cmd "it" "i")
  (sustitute-content-cmd "section[\\*]*" "h1")
  (sustitute-content-cmd "subsection[\\*]*" "h2")
  (sustitute-content-cmd "subsubsection" "h3")
  (sustitute-content-cmd "cod" "code")
)



;; Para los comandos simples sin contenido como por ejemplo \item
(defun sustitute-simple-cmd(str1 str2)
  (let ((case-fold-search t))
    (goto-char (point-min))
    (while (search-forward str1 nil t)
      (replace-match str2 t t))
    )
  )



;; Para los comandos con la forma {\str1 foobar} los modifica por
;; <str2>foobar</str2> 
(defun sustitute-pre-content-cmd(str1 str2)
  (let ((case-fold-search t))
    (goto-char (point-min))
    (while (re-search-forward (format "{\\\\%s \\([^}]*\\)}" str1) nil t)
      (replace-match (concat (format "<%s>" str2) (match-string 1) (format "</%s>" str2)) t t))
    )
  )



;; Para los comandos con la forma \str1{foobar} los modifica por
;; <str2>foobar</str2> 
(defun sustitute-content-cmd(str1 str2)
  (let ((case-fold-search t))
    (goto-char (point-min))
    (while (re-search-forward (format "\\\\%s[ ]*{\\([^}]*\\)}" str1) nil t)
      (replace-match (concat (format "<%s>" str2) (match-string 1) (format "</%s>" str2)) t t))
    )
  )


;; Para eliminar las regexp
(defun clear-regexp(rexp)
  (let ((case-fold-search t))
    (goto-char (point-min))
    (while (re-search-forward rexp nil t)
      (replace-match "" t t))
    )
  )




