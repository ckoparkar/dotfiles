(load-file "~/.emacs.d/rspec-mode/rspec-mode.el")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

;; Requires
(require 'auto-complete)
(require 'ido)
(require 'cc-mode)
(require 'paredit)
(require 'multiple-cursors)
(require 'dash)
(require 'pkg-info)
(require 'clojure-mode)
(require 'epl)
(require 'cider)
(require 'yasnippet)
(require 'pretty-mode-plus)
(require 'color-theme)
(require 'highlight-parentheses)
(require 'xclip)
(require 'feature-mode)
(require 'projectile)
(require 'flx-ido)
(require 'ido-vertical-mode)
(require 'guide-key)
(require 'expand-region)
(require 'markdown-mode)
(require 'go-mode)

;; --------------------------------------------------
;;;;;;;;;;;;;;;     Preferences     ;;;;;;;;;;;;;;;;;
;; --------------------------------------------------

(cond
 (window-system
  (set-face-attribute 'default nil :font "Monaco-12")
  (load-theme 'default-black t))

 (t
  (load-file "~/.emacs.d/modeline-no-window.el")
  (load-theme 'zenburn t)
  (turn-on-xclip)))

;; Linum
(make-face 'linum-face)
(set-face-attribute 'linum-face nil
					:foreground "#718c00"
					:weight 'bold
					)
(setq linum-format
	  (propertize "%4d  " 'face 'linum-face)
	  )

(projectile-global-mode)
(flx-ido-mode 1)
(ido-vertical-mode 1)

(key-chord-mode 1)

(blink-cursor-mode 0)

(delete-selection-mode 1)

;; guide-mode
(setq guide-key/guide-key-sequence '("C-x r" "C-x 4" "C-x v" "C-x 8"))
(guide-key-mode 1)
(setq guide-key/recursive-key-sequence-flag t)
(setq guide-key/popup-window-position 'bottom)

;; markdown-mode
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(sml-modeline-mode)

(yas-global-mode 1)
(global-auto-complete-mode t)
(global-linum-mode 1)
(global-pretty-mode 1)
(setq visible-bell t)
(setq column-number-mode 1)
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

(define-globalized-minor-mode global-highlight-parentheses-mode
  highlight-parentheses-mode
  (lambda ()
    (highlight-parentheses-mode t)
	))
(global-highlight-parentheses-mode t)


(setq inhibit-startup-message t inhibit-startup-echo-area-message t)

;; Ido completion
(setq ido-mode 1)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(setq ido-ubiquitous-mode t)
(setq ido-use-filename-at-point 'guess)
(setq ido-create-new-buffer 'always)

;; Setting up Unicode
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))

;;   Autosave settings
(defvar temporary-file-directory "~/emacs-temporary-files/")

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; --------------------------------------------------
;;;;;;;;;;;;;;;     clojure     ;;;;;;;;;;;;;;;;;;;;
;; --------------------------------------------------

;; Clojure-mode
(add-to-list 'auto-mode-alist '("\\.cljs\\'" . clojure-mode))
(add-to-list 'auto-mode-alist '("\\.cljx\\'" . clojure-mode))
(add-to-list 'auto-mode-alist '("\\.clj\\'" . clojure-mode))
;; clj-refactor: Use C-c C-m. See https://github.com/magnars/clj-refactor.el

(defun clj-refactor-hooks ()
  (clj-refactor-mode 1)
  (cljr-add-keybindings-with-prefix "C-c C-m")
  )
(add-hook 'clojure-mode-hook 'clj-refactor-hooks)

;; Cider
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
(setq nrepl-hide-special-buffers t)
(setq cider-repl-pop-to-buffer-on-connect nil)
(setq cider-popup-stacktraces nil)

;; Auto-complete
(add-hook 'clojure-mode-hook 'auto-complete-mode)
(add-hook 'lisp-mode-hook 'auto-complete-mode)
(add-hook 'lisp-interaction-mode-hook 'auto-complete-mode)

;; Smartparens
(add-hook 'clojure-mode-hook (lambda () (smartparens-mode 1)))
(add-hook 'cider-repl-mode-hook (lambda () (smartparens-mode 1)))
(add-hook 'clojure-mode-hook (lambda () (auto-auto-indent-mode 1)))

;; Idle highlight
(add-hook 'clojure-mode-hook 'idle-highlight-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; --------------------------------------------------
;;;;;;;;;;;;;;;     C/C++     ;;;;;;;;;;;;;;;;;;;;
;; --------------------------------------------------

;; C/C++ mode settings
(setq-default c-basic-offset 4 c-default-style "linux")
(setq-default tab-width 4 indent-tabs-mode t)
(define-key c-mode-base-map (kbd "RET") 'newline-and-indent)
(setq mf--source-file-extension "cpp")
(add-hook 'c++-mode-hook '(lambda () (define-key python-mode-map "\C-m" 'newline-and-indent)))

;; Auto-complete
(add-hook 'c-mode-hook 'auto-complete-mode)
(add-hook 'c++-mode-hook 'auto-complete-mode)

;; Smartparens
(add-hook 'c++-mode-hook (lambda () (smartparens-mode 1)))
(add-hook 'c-mode-hook (lambda () (smartparens-mode 1)))

;; Idle highlight
(add-hook 'c-mode-hook 'idle-highlight-mode)
(add-hook 'c++-mode-hook 'idle-highlight-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; --------------------------------------------------
;;;;;;;;;;;;;;;     Java     ;;;;;;;;;;;;;;;;;;;;
;; --------------------------------------------------

(add-hook 'java-mode-hook 'auto-auto-indent-mode)
(setq-default c-basic-offset 4 c-default-style "linux")
(setq-default tab-width 4 indent-tabs-mode t)

;; Auto-complete
(add-hook 'java-mode-hook 'auto-complete-mode)

;; Smartparens
(add-hook 'java-mode-hook (lambda () (smartparens-mode 1)))

;; Idle highlight
(add-hook 'java-mode-hook 'idle-highlight-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; --------------------------------------------------
;;;;;;;;;;;;;;;     Python     ;;;;;;;;;;;;;;;;;;;;
;; --------------------------------------------------

(add-hook 'python-mode-hook '(lambda () (define-key python-mode-map "\C-m" 'newline-and-indent)))
(add-hook 'python-mode-hook 'auto-complete-mode)

;; Smartparens
(add-hook 'python-mode-hook (lambda () (smartparens-mode 1)))

;; Idle highlight
(add-hook 'python-mode-hook 'idle-highlight-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; --------------------------------------------------
;;;;;;;;;;;;;;;     Ruby     ;;;;;;;;;;;;;;;;;;;;
;; --------------------------------------------------

(add-hook 'ruby-mode-hook 'auto-complete-mode)

;; Smartparens
(add-hook 'ruby-mode-hook (lambda () (smartparens-mode 1)))

;; Indent
(add-hook 'ruby-mode-hook '(lambda () (define-key ruby-mode-map "\C-m" 'newline-and-indent)))

;; Cucumber
(add-to-list 'auto-mode-alist '("\.feature$" . feature-mode))

;; Idle highlight
(add-hook 'ruby-mode-hook 'idle-highlight-mode)

;; Flycheck
;; (add-hook 'ruby-mode-hook 'flycheck-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; --------------------------------------------------
;;;;;;;;;;;;;;;     Lua     ;;;;;;;;;;;;;;;;;;;;
;; --------------------------------------------------

(add-to-list 'auto-mode-alist '("\\.lua\\'" . lua-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; --------------------------------------------------
;;;;;;;;;;;;;;;     Emacs-lisp     ;;;;;;;;;;;;;;;;;;;;
;; --------------------------------------------------

;; Smartparens
(add-hook 'emacs-lisp-mode-hook (lambda () (smartparens-mode 1)))
(add-hook 'lisp-mode-hook (lambda () (smartparens-mode 1)))
(add-hook 'lisp-interaction-mode-hook (lambda () (smartparens-mode 1)))


;; Autocomplete
(add-hook 'emacs-lisp-mode-hook 'auto-complete-mode)

;; Idle highlight
(add-hook 'emacs-lisp-mode-hook 'idle-highlight-mode)
(add-hook 'lisp-mode-hook 'idle-highlight-mode)
(add-hook 'lisp-interaction-mode-hook 'idle-highlight-mode)

;; --------------------------------------------------
;;;;;;;;;;;;;;;        Go        ;;;;;;;;;;;;;;;;;;;;
;; --------------------------------------------------

;; require to make goimports work.
(add-to-list 'exec-path "~/chai/go/bin")

(defun csk-go-mode-hooks ()
  (setq gofmt-command "goimports")
  (add-hook 'before-save-hook 'gofmt-before-save))

(add-hook 'go-mode-hook 'csk-go-mode-hooks)
(add-hook 'go-mode-hook (lambda () (smartparens-mode 1)))
(add-hook 'go-mode-hook 'auto-complete-mode)

;; --------------------------------------------------
;;;;;;;;;;;;;;;      Haskell    ;;;;;;;;;;;;;;;;;;;;;
;; --------------------------------------------------

(add-hook 'haskell-mode-hook 'haskell-indentation-mode)
(add-hook 'haskell-mode-hook 'auto-complete-mode)
(add-hook 'haskell-mode-hook (lambda () (smartparens-mode 1)))
