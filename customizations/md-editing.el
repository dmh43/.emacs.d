(autoload 'mardown-mode "Markdown" "Markdown Mode" t)
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-hook 'markdown-mode-hook 'auto-fill-mode)

(provide 'md-editing)
