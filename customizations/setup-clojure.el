;;;;
;; Clojure
;;;;
(add-hook 'clojure-mode-hook 'cider-mode)

;; Enable paredit for Clojure
(add-hook 'clojure-mode-hook 'enable-paredit-mode)

;; This is useful for working with camel-case tokens, like names of
;; Java classes (e.g. JavaClassName)
(add-hook 'clojure-mode-hook 'subword-mode)

;; A little more syntax highlighting
(require 'clojure-mode-extra-font-locking)

(require 'clj-refactor)

;; syntax hilighting for midje
(add-hook 'clojure-mode-hook
          (lambda ()
            (setq inferior-lisp-program "lein repl")
            (font-lock-add-keywords
             nil
             '(("(\\(facts?\\)"
                (1 font-lock-keyword-face))
               ("(\\(background?\\)"
                (1 font-lock-keyword-face))))
            (define-clojure-indent (fact 1))
            (define-clojure-indent (facts 1))
            (clj-refactor-mode 1)
            (yas-minor-mode 1) ; for adding require/use/import statements
            ;; This choice of keybinding leaves cider-macroexpand-1 unbound
            (cljr-add-keybindings-with-prefix "C-c C-m")))

;;;;
;; Cider
;;;;

;; provides minibuffer documentation for the code you're typing into the repl
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)

;; go right to the REPL buffer when it's finished connecting
;(setq cider-repl-pop-to-buffer-on-connect t)

;; When there's a cider error, show its buffer and switch to it
(setq cider-show-error-buffer t)
(setq cider-auto-select-error-buffer t)

;; Where to store the cider history.
(setq cider-repl-history-file "~/.emacs.d/cider-history")

;; Wrap when navigating history.
(setq cider-repl-wrap-history t)

;; enable paredit in your REPL
(add-hook 'cider-repl-mode-hook 'paredit-mode)

;; Use clojure mode for other extensions
(add-to-list 'auto-mode-alist '("\\.edn$" . clojure-mode))
(add-to-list 'auto-mode-alist '("\\.boot$" . clojure-mode))
(add-to-list 'auto-mode-alist '("\\.cljs.*$" . clojure-mode))
(add-to-list 'auto-mode-alist '("lein-env" . enh-ruby-mode))

(setq clojure-imenu-generic-expression
      '((nil "^\\s-*(\\(?:s\\|t/\\)?defn-?\\s-+\\(?:\\^[^[:space:]\n]+\\s-+\\)?\\([^[:space:]\n]+\\)" 1)
        ("Variable""^\\s-*(\\(?:s\\|t/\\)?def[[:space:]\n]+\\(?:\\(?:\\^{[^}]+}[[:space:]\n]+\\)\\|\\(?:\\^:[^[:space:]\n]+\\s-+\\)\\)?\\([^[:space:]\n\)]+\\)" 1)
        ("Macro" "^\\s-*(defmacro\\s-+\\([^[:space:]\n]+\\)" 1)
        ("Record" "^\\s-*(\\(?:s/\\)?defrecord\\s-+\\([^[:space:]\n]+\\)" 1)
        ("Type" "^\\s-*(deftype\\+?\\s-+\\([^[:space:]\n]+\\)" 1)
        ("Protocol" "^\\s-*(\\(?:def\\(?:-abstract-type\\|interface\\+?\\|protocol\\)\\)\\s-+\\([^[:space:]\n]+\\)" 1)
        ("Multimethod" "^\\s-*(defmulti\\s-+\\([^[:space:]\n]+\\)" 1)
        ("Multimethod" "^\\s-*(defmethod\\s-+\\([^[:space:]\n]+\\)" 1)))


(eval-after-load "clojure-mode"
  '(progn
     (add-hook
      'clojure-mode-hook
      (lambda ()
        (progn
          (setq imenu-generic-expression clojure-imenu-generic-expression
                imenu-create-index-function 'imenu-default-create-index-function))))))


;; key bindings
;; these help me out with the way I usually develop web apps
(defun cider-start-http-server ()
  (interactive)
  (cider-load-current-buffer)
  (let ((ns (cider-current-ns)))
    (cider-repl-set-ns ns)
    (cider-interactive-eval (format "(println '(def server (%s/start))) (println 'server)" ns))
    (cider-interactive-eval (format "(def server (%s/start)) (println server)" ns))))


;; (defun cider-refresh ()
  ;; (interactive)
  ;; (cider-interactive-eval (format "(user/reset)")))

;; (defun cider-user-ns ()
  ;; (interactive)
  ;; (cider-repl-set-ns "user"))

;; (eval-after-load 'cider
  ;; '(progn
     ;; (define-key clojure-mode-map (kbd "C-c C-v") 'cider-start-http-server)
     ;; (define-key clojure-mode-map (kbd "C-M-r") 'cider-refresh)
     ;; (define-key clojure-mode-map (kbd "C-c u") 'cider-user-ns)
     ;; (define-key cider-mode-map (kbd "C-c u") 'cider-user-ns)))
