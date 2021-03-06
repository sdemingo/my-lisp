
;;
;;   Configuración de web-mode y multi-web-mode
;;


(require 'multi-web-mode)
(setq mweb-default-major-mode 'html-mode)
(setq mweb-tags 
      '((php-mode "<\\?php\\|<\\? \\|<\\?=" "\\?>")
	(js-mode  "<script[^>]*>" "</script>")
	(css-mode "<style[^>]*>" "</style>")))
(setq mweb-filename-extensions '("php" "htm" "html" "ctp" "phtml" "php4" "php5"))
(multi-web-global-mode 1)



(require 'flymake-jslint)
(add-hook 'js-mode-hook 'flymake-jslint-load)
