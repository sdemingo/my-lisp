
;;
;; Configuracón del modo para Go
;;


(require 'go-mode-load)
(require 'go-autocomplete)
(require 'auto-complete-config)
(ac-config-default)

(setenv "GOROOT" "/opt/go")
(setenv "GOPATH" "/home/sdemingo/src/go")
(setenv "GOBIN" (concat (directory-file-name (getenv "GOPATH")) "/bin"))


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

(defun my-go-mode-hook ()
  ; Use goimports instead of go-fmt
  (setq gofmt-command "goimports")
  ; Call Gofmt before saving
  (add-hook 'before-save-hook 'gofmt-before-save)
  ; Customize compile command to run go build
  (if (not (string-match "go" compile-command))
      (set (make-local-variable 'compile-command)
           ;"go build -v && go test -v && go vet"))
	   "go build -v"))
  ; Godef jump key binding
  (local-set-key (kbd "M-.") 'godef-jump))


(defun go-run ()
  "Arranca un código usando usando el comando go run"
  (interactive)
  (if (string-match "\\.go$" (buffer-file-name))
      (shell-command (concat "go run " (buffer-file-name)))))


; Call Gofmt before saving
(add-hook 'before-save-hook 'gofmt-before-save)
(add-hook 'go-mode-hook 'my-go-mode-hook)
