

(require 'undo-tree)

;; Activo por defecto el undo tree
(global-undo-tree-mode)

;; Visualizar el arbol siempre en una ventana lateral
(defadvice undo-tree-visualize (around undo-tree-split-side-by-side activate)
  "Split undo-tree side-by-side"
  (let ((split-height-threshold nil)
        (split-width-threshold 0))
  ad-do-it))
