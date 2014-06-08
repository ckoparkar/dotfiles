;; (add-to-list 'load-path "~/.emacs.d/plugins/")
;; (add-to-list 'load-path "~/.emacs.d/plugins/multiple-cursors/")
;; (add-to-list 'load-path "~/.emacs.d/plugins/cider/")
;; (add-to-list 'load-path "~/.emacs.d/plugins/auto-complete-1.3.1/")
;; (add-to-list 'load-path "~/.emacs.d/plugins/clojure-mode/")
;; (add-to-list 'load-path "~/.emacs.d/plugins/dash/")
;; (add-to-list 'load-path "~/.emacs.d/plugins/pkg-info/")
;; (add-to-list 'load-path "~/.emacs.d/plugins/epl/")
;; (add-to-list 'load-path "~/.emacs.d/plugins/yasnippet/")
;; (add-to-list 'load-path "~/.emacs.d/plugins/pretty-mode-plus/")
;; (add-to-list 'load-path "~/.emacs.d/plugins/color-theme")
;; (add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

;; (load-file "~/.emacs.d/plugins/smex.el")
;; (load-file "~/.emacs.d/plugins/highlight-parenthesis.el")
;; (load-file "~/.emacs.d/plugins/paredit.el")
;; (load-file "~/.emacs.d/plugins/sml-modeline.el")
;; (load-file "~/.emacs.d/plugins/rainbow-delimiters.el")
;; (load-file "~/.emacs.d/plugins/s.el")
;; (load-file "~/.emacs.d/plugins/clj-refactor.el")
;; (load-file "~/.emacs.d/plugins/xclip.el")
;; (load-file "~/.emacs.d/plugins/smartparens.el")
;; (load-file "~/.emacs.d/plugins/four-clj.el")
;; (load-file "~/.emacs.d/plugins/nyan-mode/nyan-mode.el")
;; (load-file "~/.emacs.d/plugins/iy-go-to-char.el")

;;(load-file "~/.emacs.d/plugins/auto-indent-mode.el")
;;(load-file "~/.emacs.d/plugins/pymacs.el")
;;(add-to-list 'load-path "~/.emacs.d/plugins/zenburn-theme-2.1/")
;;(load-file "~/.emacs.d/plugins/doc-mode.el")
;;(load-file "~/.emacs.d/arduino-mode/arduino-mode.el")
;;(load-file "~/.emacs.d/emacs-for-python/epy-init.el")
;;(load-file "~/.emacs.d/cedet/cedet-devel-load.el")

(load-file "~/.emacs.d/plugins/nyan-mode/nyan-mode.el")

;; Requires
(require 'auto-complete)
(require 'ido)
(require 'rainbow-delimiters)
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
;;(require 'four-clj)


;; --------------------------------------------------
;;;;;;;;;;;;;;;     Preferences     ;;;;;;;;;;;;;;;;;
;; --------------------------------------------------


(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'zenburn t)
;;(load-theme 'dorsey t)
;;(load-theme 'brin t)
;;(load-theme 'hickey t)
;;(load-theme 'junio t)
;;(load-theme 'odersky t)


;; Linum
(make-face 'linum-face)
(set-face-attribute 'linum-face nil
					:foreground "#718c00"
					:weight 'bold
					)

(setq linum-format
	  (propertize "%4d  " 'face 'linum-face)
  )

(sml-modeline-mode)
(global-rainbow-delimiters-mode)

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

;; Smartparens settings

;;(require 'smartparens-config)
;;(smartparens-global-mode t)
;;(show-smartparens-global-mode t)
;;(sp-with-modes sp--lisp-modes (sp-local-pair "(" nil :bind "C-("))
;;(add-hook 'c++-mode-hook (lambda () (smartparens-mode 1)))
;;(add-hook 'c-mode-hook (lambda () (smartparens-mode 1)))
;;(add-hook 'python-mode-hook (lambda () (smartparens-mode 1)))


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

;; Rainbow-delimeters
(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)
(add-hook 'lisp-mode-hook 'rainbow-delimiters-mode)
(add-hook 'lisp-interaction-mode-hook 'rainbow-delimiters-mode)

;; Auto-complete
(add-hook 'clojure-mode-hook 'auto-complete-mode)
(add-hook 'lisp-mode-hook 'auto-complete-mode)
(add-hook 'lisp-interaction-mode-hook 'auto-complete-mode)

;; Paredit
;;(add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
;;(add-hook 'clojure-mode-hook 'paredit-mode)
;;(add-hook 'cider-repl-mode-hook 'paredit-mode)
;;(add-hook 'lisp-mode-hook 'enable-paredit-mode)
;;(add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)


;; Smartparens
(add-hook 'clojure-mode-hook (lambda () (smartparens-mode 1)))
(add-hook 'cider-repl-mode-hook (lambda () (smartparens-mode 1)))
(add-hook 'emacs-lisp-mode-hook (lambda () (smartparens-mode 1)))
(add-hook 'lisp-mode-hook (lambda () (smartparens-mode 1)))
(add-hook 'lisp-interaction-mode-hook (lambda () (smartparens-mode 1)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; --------------------------------------------------
;;;;;;;;;;;;;;;     C/C++     ;;;;;;;;;;;;;;;;;;;;
;; --------------------------------------------------

;; C/C++ mode settings
(setq-default c-basic-offset 4 c-default-style "linux")
(setq-default tab-width 4 indent-tabs-mode t)
;;(define-key c-mode-base-map (kbd "RET") 'newline-and-indent) taken care by auto-indent CHECK;;
(setq mf--source-file-extension "cpp")
(add-hook 'c++-mode-hook '(lambda () (define-key python-mode-map "\C-m" 'newline-and-indent)))

;; Rainbow-delimeters
(add-hook 'c-mode-hook 'rainbow-delimiters-mode)
(add-hook 'c++-mode-hook 'rainbow-delimiters-mode)

;; Auto-complete
(add-hook 'c-mode-hook 'auto-complete-mode)
(add-hook 'c++-mode-hook 'auto-complete-mode)

;; Paredit
;;(add-hook 'c-mode-hook 'paredit-mode)
;;(add-hook 'c++-mode-hook 'paredit-mode)
(add-hook 'c++-mode-hook (lambda () (smartparens-mode 1)))
(add-hook 'c-mode-hook (lambda () (smartparens-mode 1)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; --------------------------------------------------
;;;;;;;;;;;;;;;     Python     ;;;;;;;;;;;;;;;;;;;;
;; --------------------------------------------------

(add-hook 'python-mode-hook '(lambda () (define-key python-mode-map "\C-m" 'newline-and-indent)))
(add-hook 'python-mode-hook 'auto-complete-mode)
;;(add-hook 'python-mode-hook 'jedi:ac-setup)

;; Paredit
;;(add-hook 'python-mode-hook 'enable-paredit-mode)
(add-hook 'python-mode-hook (lambda () (smartparens-mode 1)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; --------------------------------------------------
;;;;;;;;;;;;;;;     Arduino     ;;;;;;;;;;;;;;;;;;;;
;; --------------------------------------------------

(setq ede-arduino-appdir "/usr/share/arduino")
(setq auto-mode-alist (cons '("\\.\\(pde\\|ino\\)$" . arduino-mode) auto-mode-alist))
(autoload 'arduino-mode "arduino-mode" "Arduino editing mode." t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
