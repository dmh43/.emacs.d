;; (add-hook 'find-file-hook 'flymake-find-file-hook)
(require 'helm-config)
(add-hook 'after-init-hook #'global-flycheck-mode)
(add-hook 'after-init-hook 'global-company-mode)
;(add-hook 'python-mode-hook 'jedi:setup)
(add-hook 'inferior-python-mode-hook 'eldoc-mode)
                                        ;(add-hook 'inferior-python-mode-hook 'jedi:setup)
(add-hook 'inferior-python-mode-hook 'anaconda-mode)

(when (executable-find "ipython")
  (setq python-shell-interpreter "ipython"))

(eval-after-load "company"
 '(progn
   (add-to-list 'company-backends 'company-anaconda)))
  
(require 'nose)
(require 'emacs-virtualenv)

(add-hook #'python-mode-hook
             '(lambda ()
                (local-set-key (kbd "C-c ,") 'nose-virtualenv-test-all)
                (eldoc-mode)
                (flycheck-virtualenv-setup)
                (activate-project-virtualenv)
                (anaconda-mode)))

(require 'pymacs)
(pymacs-load "ropemacs" "rope-")

;; Configure flymake for Python
;; (when (load "flymake" t)
;;   (defun flymake-pylint-init ()
;;     (let* ((temp-file (flymake-init-create-temp-buffer-copy
;;                        'flymake-create-temp-inplace))
;;            (local-file (file-relative-name
;;                         temp-file
;;                         (file-name-directory buffer-file-name))))
;;       (list "epylint" (list local-file))))
;;   (add-to-list 'flymake-allowed-file-name-masks
;;                '("\\.py\\'" flymake-pylint-init)))

;; Set as a minor mode for Python
;; (add-hook 'python-mode-hook '(lambda () (flymake-mode)))

;; To avoid having to mouse hover for the error message, these functions make flymake error messages
;; appear in the minibuffer
;; (defun show-fly-err-at-point ()
;;   "If the cursor is sitting on a flymake error, display the message in the minibuffer"
;;   (require 'cl)
;;   (interactive)
;;   (let ((line-no (line-number-at-pos)))
;;     (dolist (elem flymake-err-info)
;;       (if (eq (car elem) line-no)
;;       (let ((err (car (second elem))))
;;         (message "%s" (flymake-ler-text err)))))))

;; (add-hook 'post-command-hook 'show-fly-err-at-point)

(provide 'python-editing)
