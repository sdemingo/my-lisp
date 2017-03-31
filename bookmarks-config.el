;;
;; Fichero de configuración de bookmarks
;;

(setq  bookmark-default-file "~/.emacs.d/bookmarks") ;; keep my ~/ clean
(setq  bookmark-save-flag 1)                       ;; autosave each change)


;; Función para guardar bookmarks en fichero orgmode


(setq bookmark-orgmode-file "~/org/enlaces.org")


(defun bookmark-save-orgmode()
  "Añade un enlace como favorito a un fichero en formato org-mode"
  (interactive)
  (setq prefix "http://")
  (setq iurl (read-string "Enlace: "))
  (if (string-prefix-p prefix iurl)
      (setq url iurl)
    (setq url (concat prefix iurl))
    )

  (setq tags-list (sort (mapcar 'car (org-global-tags-completion-table)) #'string<))
  (setq sort-tags-list (mapconcat 'identity tags-list "|"))

  (setq title (read-string "Título: "))
  (setq desc (read-string "Descripción: "))
  (setq tags (replace-regexp-in-string "[\|.,; ]+" ":" 
				       (read-string 
					(format "Etiquetas \n%s: " sort-tags-list))))
  
  (setq stamp (format-time-string "%Y-%m-%d %a %H:%M"))
  (setq prop (format ":PROPERTIES:\n:CREATED: <%s>\n:END:" stamp))
  (if (= (length tags) 0)
      (write-region (format "*** [[%s][%s]]\n%s\n%s\n" url title prop desc) 
		    nil bookmark-orgmode-file 'append)
    
    (write-region (format "*** [[%s][%s]] \t\t\t:%s:\n%s\n%s\n" url title tags prop desc) 
		  nil bookmark-orgmode-file 'append)
    )
  )

