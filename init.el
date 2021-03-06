;;;;
;; Packages
;;;;

;; Define package repositories
;; (require 'package)
;; (add-to-list 'package-archives
             ;; '("marmalade" . "http://marmalade-repo.org/packages/") t)
;; (add-to-list 'package-archives
             ;; '("tromey" . "http://tromey.com/elpa/") t)

;; (setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
;;                          ("marmalade" . "http://marmalade-repo.org/packages/")
;;                          ("melpa" . "http://melpa-stable.milkbox.net/packages/")))
;; (when (>= emacs-major-version 24)
;;   (require 'package)
;;   (add-to-list
;;    'package-archives
;;    '("melpa" . "http://melpa.org/packages/")
;;    t)
;;   (package-initialize))

;;; Emacs is not a package manager, and here we load its package manager!
(require 'package)
(dolist (source '(;("marmalade" . "http://marmalade-repo.org/packages/")
                  ;("elpa" . "http://tromey.com/elpa/")
                  ;; TODO: Maybe, use this after emacs24 is released
                  ;; (development versions of packages)
                                        ;("melpa" . "http://melpa.milkbox.net/packages/")
                  ("gnu" . "https://elpa.gnu.org/packages/")
                  ;("marmalade" . "https://marmalade-repo.org/packages/")
                  ("melpa-stable" . "https://stable.melpa.org/packages/")
                  ))
  (add-to-list 'package-archives source t))

;; Load and activate emacs packages. Do this first so that the
;; packages are loaded before you start trying to modify them.
;; This also sets the load path.
(package-initialize)

;; Download the ELPA archive description if needed.
;; This informs Emacs about the latest versions of all packages, and
;; makes them available for download.
(when (not package-archive-contents)
  (package-refresh-contents))

;; The packages you want installed. You can also install these
;; manually with M-x package-install
;; Add in your own as you wish:
(defvar my-packages
  '(paredit
    clojure-mode
    clojure-mode-extra-font-locking
    cider
    ido-ubiquitous
    smex
    projectile
    rainbow-delimiters
    tagedit
    magit))

;; On OS X, an Emacs instance started from the graphical user
;; interface will have a different environment than a shell in a
;; terminal window, because OS X does not run a shell during the
;; login. Obviously this will lead to unexpected results when
;; calling external utilities like make from Emacs.
;; This library works around this problem by copying important
;; environment variables from the user's shell.
;; https://github.com/purcell/exec-path-from-shell
(if (eq system-type 'darwin)
    (add-to-list 'my-packages 'exec-path-from-shell))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))


;;;;
;; Customization
;;;;

;; Add a directory to our load path so that when you `load` things
;; below, Emacs knows where to look for the corresponding file.
(add-to-list 'load-path "~/.emacs.d/customizations")
(add-to-list 'load-path "~/.emacs.d/scripts")

(load "shell-integration.el")
(load "navigation.el")
(load "ui.el")
(load "editing.el")
(load "misc.el")
(load "elisp-editing.el")
(load "setup-clojure.el")
(load "setup-js.el")
(load "setup-helm.el")
(load "c-editing.el")
(load "md-editing.el")
(load "python-editing.el")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(coffee-tab-width 2)
 '(custom-safe-themes
   (quote
    ("135bbd2e531f067ed6a25287a47e490ea5ae40b7008211c70385022dbab3ab2a" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default)))
 '(ecb-directories-menu-user-extension-function nil)
 '(ecb-history-menu-user-extension-function nil)
 '(ecb-methods-menu-user-extension-function nil)
 '(ecb-options-version "2.24")
 '(ecb-sources-menu-user-extension-function nil)
 '(exec-path
   (quote
    ("/usr/local/bin" "/usr/bin" "/bin" "/usr/local/games" "/usr/games" "/usr/lib/emacs/24.4/i586-linux-gnu" "/home/dany/bin")))
 '(ggtags-process-environment (quote ("GTAGSLIBPATH=/home/dany/.gtags")))
 '(helm-gtags-prefix-key "C-t")
 '(helm-gtags-suggested-key-mapping t)
 '(projectile-enable-caching t)
 '(scroll-conservatively 101)
 '(shell-file-name "/bin/bash")
 '(show-paren-mode t)
 '(split-height-threshold 40)
 '(split-width-threshold 160))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Droid Sans Mono" :foundry "unknown" :slant normal :weight normal :height 90 :width normal))))
 '(magit-item-highlight ((t (:background "dark violet" :foreground "white")))))

(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
              (ggtags-mode 1))))

(require 'helm-gtags)
;; Enable helm-gtags-mode
(add-hook 'dired-mode-hook 'helm-gtags-mode)
(add-hook 'eshell-mode-hook 'helm-gtags-mode)
(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(add-hook 'asm-mode-hook 'helm-gtags-mode)

(add-hook 'c-mode-common-hook   'hs-minor-mode)
(add-hook 'emacs-lisp-mode-hook 'hs-minor-mode)
(add-hook 'python-mode-hook 'hs-minor-mode)
(add-hook 'clojure-mode-hook 'hs-minor-mode)
(add-hook 'java-mode-hook       'hs-minor-mode)
(add-hook 'lisp-mode-hook       'hs-minor-mode)
(add-hook 'perl-mode-hook       'hs-minor-mode)
(add-hook 'sh-mode-hook         'hs-minor-mode)

(global-undo-tree-mode)
(column-number-mode)

(require 'diminish)
(dolist
    (mode
     '(company-mode clojure-mode undo-tree-mode helm-mode eldoc-mode magit-auto-revert-mode paredit-mode projectile-mode cider-popup-buffer-mode auto-fill-mode
                    flymake-mode anaconda-mode elisp-slime-nav-mode back-button-mode helm-gtags-mode))
  (diminish mode (substring (symbol-name mode) 0 2)))
(winner-mode)

(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

(require 'flx-ido)
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
;; disable ido faces to see flx highlights.
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)

(require 'key-chord)
(key-chord-mode 1)

(key-chord-define-global "``" 'helm-mini)
(key-chord-define-global "`1" 'helm-imenu-in-all-buffers)
(key-chord-define-global "`2" 'helm-imenu)

(require 'yasnippet nil 'noerror)
(yas/load-directory "~/.emacs.d/snippets")

(defvar yas-minor-mode-map nil)

(windmove-default-keybindings 'super)

(require 'buffer-move)

(global-set-key (kbd "<C-s-up>")     'buf-move-up)
(global-set-key (kbd "<C-s-down>")   'buf-move-down)
(global-set-key (kbd "<C-s-left>")   'buf-move-left)
(global-set-key (kbd "<C-s-right>")  'buf-move-right)

(require 'which-key)
(which-key-mode)

(require 'back-button)
(back-button-mode 1)

(require 'crux)

(global-set-key (kbd "s-o") 'crux-smart-open-line)
(global-set-key (kbd "s-O") 'crux-smart-open-line-above)
(global-set-key (kbd "s-k s-k") 'crux-kill-whole-line)

(global-set-key (kbd "<f1>") 'flycheck-list-errors)
(global-set-key (kbd "<f2>") 'flycheck-previous-error)
(global-set-key (kbd "<f3>") 'flycheck-next-error)

;(require 'reload-desktop)

                                        ;(reload-desktop-save-mode 1)
(desktop-save-mode 1)

;; Functions
(defun next-other-buffer (arg)
  (interactive "p")
  (other-window arg)
  (next-buffer)
  (other-window arg))
(defun previous-other-buffer (arg)
  (interactive "p")
  (other-window arg)
  (previous-buffer)
  (other-window arg))

(global-set-key (kbd "C-x C-p") 'previous-buffer)
(global-set-key (kbd "C-x C-n") 'next-buffer)
(global-set-key (kbd "C-x 4 C-p") 'previous-other-buffer)
(global-set-key (kbd "C-x 4 C-n") 'next-other-buffer)

(defadvice keyboard-escape-quit (around my-keyboard-escape-quit activate)
  "Don't allow esc esc esc to destroy other windows"
  (let (orig-one-window-p)
    (fset 'orig-one-window-p (symbol-function 'one-window-p))
    (fset 'one-window-p (lambda (&optional nomini all-frames) t))
    (unwind-protect
        ad-do-it
      (fset 'one-window-p (symbol-function 'orig-one-window-p)))))

(defun copy-line ()
  (interactive)
  (save-excursion
    (back-to-indentation)
    (set-mark-command nil)
    (move-end-of-line nil)
    (kill-ring-save (mark) (point))))

(global-set-key (kbd "s-y s-y") 'copy-line)
