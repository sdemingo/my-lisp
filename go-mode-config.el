
;;
;; Configuracón del modo para Go
;;



(require 'go-mode-load)
(setenv "GOROOT" "/opt/go")
(setenv "GOPATH" "/home/sdemingo/src/go")
;(setenv "GOBIN" (concat (directory-file-name (getenv "GOROOT")) "/bin"))


;; (add-hook 'before-save-hook 'gofmt-before-save)
;; (add-hook 'go-mode-hook (lambda ()
;; 			  (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)))
;; add-hook 'go-mode-hook (lambda ()
;; 			 (local-set-key (kbd "C-c i") 'go-goto-imports)))



(defun godoc-lookup()
  "Load a godoc page in the browse"
  (interactive)
  (setq pk (read-string "What package do you want to explore? [index by default]: "))
  (setq pk (concat "http://golang.org/pkg/" pk))
  (browse-url pk)
)


(defun go-compile ()
  "Compila go usando el comando go build"
  (interactive)
  (if (string-match "\\.go$" (buffer-file-name))
      (shell-command (concat "go build " (buffer-file-name)))))



(defun go-run ()
  "Arranca un código usando usando el comando go run"
  (interactive)
  (if (string-match "\\.go$" (buffer-file-name))
      (shell-command (concat "go run " (buffer-file-name)))))