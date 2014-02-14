
;;
;; Configuración de ispell
;;



(autoload 'ispell-word "ispell" "Check the spelling of word in buffer." 
't)
(autoload 'ispell-region "ispell" "Check the spelling of region." 't)
(autoload 'ispell-buffer "ispell" "Check the spelling of buffer." t)
(global-set-key (read-kbd-macro "M-$") 'ispell-word)
(setq ispell-dictionary "spanish"
     ispell-skip-sgml t)
(autoload 'flyspell-mode "flyspell" "On-the-fly spelling checking" t)
(setq flyspell-default-dictionary "spanish")
