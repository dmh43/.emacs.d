(require 'ggtags)

(defun cpp-init ()
  (require 'autopair)
  (autopair-mode)
  (setq autopair-autowrap t)
  (require 'auto-complete-clang)
  (define-key c++-mode-map (kbd "C-S-<return>") 'ac-complete-clang)
  (require 'member-functions)
  (setq mf--source-file-extension "cpp")
  (require 'flymake))

(add-hook 'c++-mode-hook 'cpp-init)

(provide 'c-editing)
