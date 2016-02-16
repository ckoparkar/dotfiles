;; (load-file "~/.emacs.d/rspec-mode/rspec-mode.el")
;; (load-file "~/.emacs.d/rutable/rutable.el")
;; (load-file "~/.emacs.d/emacs-rustfmt/rustfmt.el")

(require 'cc-mode)
(require 'use-package)
(require 'dash)
(require 's)
(require 'f)


(defun load-local (file)
  (load (f-expand file user-emacs-directory)))


(load-local "defuns")
(load-local "keybindings")
(load-local "default-black-theme")

;; --------------------------------------------------
;;;;;;;;;;;;;;;     Preferences     ;;;;;;;;;;;;;;;;;
;; --------------------------------------------------


;; initialize theme and modeline based on os
(cond
 ((memq window-system '(x))
  (load-theme 'default-black t)
  (set-face-attribute 'default nil :font "Monaco-12"))

 ((eq system-type 'darwin)
  (load-theme 'default-black t)
  (exec-path-from-shell-initialize)
  (set-face-attribute 'default nil :font "Monaco-14"))

 (t
  (load-file "~/.emacs.d/modeline-no-window.el")
  (turn-on-xclip)))


;; programming utils
(use-package auto-complete
  :init
  (progn
    (add-hook 'clojure-mode-hook 'auto-complete-mode)
    (add-hook 'lisp-mode-hook 'auto-complete-mode)
    (add-hook 'lisp-interaction-mode-hook 'auto-complete-mode)
    (add-hook 'ruby-mode-hook 'auto-complete-mode)
    (add-hook 'emacs-lisp-mode-hook 'auto-complete-mode)
    (add-hook 'go-mode-hook 'auto-complete-mode)
    (add-hook 'rust-mode-hook 'auto-complete-mode)
    (add-hook 'haskell-mode-hook 'auto-complete-mode)
    (add-hook 'js2-mode-hook 'auto-complete-mode)))


(use-package auto-auto-indent
  :init
  (progn
    (add-hook 'clojure-mode-hook (lambda () (auto-auto-indent-mode 1)))))


(use-package multiple-cursors
  :defer t
  :bind (("M->" . mc/mark-next-like-this)
         ("M-<" . mc/mark-previous-like-this)
         ("C-x ." . mc/mark-all-like-this)
         ("C-x /" . mc/edit-lines)))


(use-package projectile
  :init (projectile-global-mode)
  :config
  (progn
    (setq projectile-enable-caching t)
    (setq projectile-require-project-root nil)
    (setq projectile-completion-system 'ido)
    (add-to-list 'projectile-globally-ignored-files ".DS_Store")))


(use-package ace-jump-mode
  :bind ("C-c SPC" . ace-jump-mode))


(use-package magit-mode
  :init (setq magit-last-seen-setup-instructions "1.4.0")
  :config
  (progn
    ;; (set-face-foreground 'magit-diff-add "green3")
    ;; (set-face-background 'magit-diff-add "#000012")
    ;; (set-face-foreground 'magit-diff-del "red3")
    ;; (set-face-background 'magit-diff-del "#000012")
    ;; (set-face-background 'magit-item-highlight "black")
    ))


(use-package expand-region
  :bind ("C-=" . er/expand-region))


(use-package undo-tree
  :bind ("C-x u" . undo-tree-visualize))


(use-package exec-path-from-shell)

(use-package rustfmt)

(use-package xclip)


(use-package yasnippet
  :init (yas-global-mode 1))


(use-package inf-ruby
  :init (add-hook 'ruby-mode-hook 'inf-ruby-minor-mode))


(use-package rvm
  :init (add-hook 'ruby-mode-hook (lambda () (rvm-activate-corresponding-ruby))))


(use-package flycheck)


;; better looking

(use-package pretty-mode-plus
  :config (global-pretty-mode 1))


(use-package sml-modeline
  :init (sml-modeline-mode))


(use-package nyan-mode
  :init (nyan-mode 1))


;; IDO completion

(use-package ido
  :defer t
  :init
  (progn
    (ido-mode 1)
    (ido-everywhere 1))
  :config
  (progn
    (defun ido-my-keys ()
      (define-key ido-common-completion-map (kbd "C-n") 'ido-next-match)
      (define-key ido-common-completion-map (kbd "C-p") 'ido-prev-match))
    (add-hook 'ido-setup-hook 'ido-my-keys)
    (setq ido-mode 1)
    (setq ido-enable-flex-matching t)
    (setq ido-everywhere t)
    (setq ido-ubiquitous-mode t)
    (setq ido-use-filename-at-point 'guess)
    (setq ido-create-new-buffer 'always)))


(use-package flx-ido
  :init (flx-ido-mode 1))


(use-package ido-vertical-mode
  :init (ido-vertical-mode 1))

(use-package smex)

;; managing parens

(use-package smartparens
  :init
  (progn
    (smartparens-global-strict-mode 1)
    (smartparens-global-mode 1)
    (sp-pair "'" nil :actions :rem)
    (add-hook 'cider-repl-mode-hook (lambda () (smartparens-mode 1)))
    (add-hook 'clojure-mode-hook (lambda () (smartparens-mode 1)))
    (add-hook 'ruby-mode-hook (lambda () (smartparens-mode 1)))
    (add-hook 'emacs-lisp-mode-hook (lambda () (smartparens-mode 1)))
    (add-hook 'lisp-mode-hook (lambda () (smartparens-mode 1)))
    (add-hook 'lisp-interaction-mode-hook (lambda () (smartparens-mode 1)))
    (add-hook 'go-mode-hook (lambda () (smartparens-mode 1)))
    (add-hook 'rust-mode-hook (lambda () (smartparens-mode 1)))
    (add-hook 'haskell-mode-hook (lambda () (smartparens-mode 1)))
    (add-hook 'js2-mode-hook (lambda () (smartparens-mode 1)))
    (add-hook 'lisp-interaction-mode-hook (lambda () (smartparens-mode 1)))))


;; clojure utils

(use-package clj-refactor
  :init
  (progn
    (add-hook 'clojure-mode-hook
              (lambda ()
                (clj-refactor-mode 1)
                (yas-minor-mode 1)
                (cljr-add-keybindings-with-prefix "C-c C-m")))))


(use-package cider
  :config
  (progn
    (add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
    (setq nrepl-hide-special-buffers t)
    (setq cider-repl-pop-to-buffer-on-connect nil)
    (setq cider-popup-stacktraces nil))
  :bind (("C-c r". cider-repl-reset)))


;; major modes

(use-package clojure-mode
  :mode (("\\.clj\\'" . clojure-mode)
         ("\\.cljx\\'" . clojure-mode)
         ("\\.cljs\\'" . clojure-mode)))


(use-package go-mode
  :config
  (progn
    (defun csk-go-mode-hooks ()
      (add-to-list 'exec-path "~/chai/go/bin")
      (setq gofmt-command "gofmt")
      (setq tab-width 8 indent-tabs-mode 1))

    (add-hook 'go-mode-hook 'csk-go-mode-hooks)
    (add-hook 'before-save-hook 'gofmt-before-save)))


(use-package ruby-mode
  :init
  (progn
    (add-hook 'ruby-mode-hook '(lambda () (define-key ruby-mode-map "\C-m" 'newline-and-indent)))))


(use-package feature-mode
  :mode (("\.feature$" . feature-mode)))


(use-package rust-mode
  :init (add-hook 'rust-mode-hook #'rustfmt-enable-on-save))


(use-package lua-mode
  :mode (("\\.lua\\'" . lua-mode)))


(use-package markdown-mode
  :mode
  (("\\.markdown\\'" . markdown-mode)
   ("\\.md\\'" . markdown-mode)))


;; (use-package delete-selection-mode
;;   :init (delete-selection-mode 0))


(use-package yaml-mode
  :defer t
  :mode ("\\.yml$" . yaml-mode))


(use-package restclient
  :mode (("\\.rest\\'" . restclient-mode)))


(use-package js2-mode
  :init
  (progn
    (setq js2-highlight-level 3)
    (add-hook 'js2-mode-hook (lambda () (flycheck-mode t)))
    (add-hook 'js2-mode-hook 'ac-js2-mode)))


;; Misc stuff

(define-globalized-minor-mode global-highlight-parentheses-mode
  highlight-parentheses-mode
  (lambda ()
    (highlight-parentheses-mode t)
    ))
(global-highlight-parentheses-mode t)


;; setup linum
(make-face 'linum-face)
(set-face-attribute 'linum-face nil
                    :foreground "#718c00"
                    :weight 'bold)
(setq linum-format (propertize "%4d  " 'face 'linum-face))
(global-linum-mode 1)

;; enable y/n answers
(fset 'yes-or-no-p 'y-or-n-p)

;; delete the selection with a keypress
;; If you enable Delete Selection mode, a minor mode, then inserting text while the mark is active causes the selected text to be deleted first. This also deactivates the mark. Many graphical applications follow this convention, but Emacs does not.
(delete-selection-mode t)

;; revert buffers automatically when underlying files are changed externally
(global-auto-revert-mode t)

;; Newline at end of file
(setq require-final-newline t)

;; more useful frame title, that show either a file or a
;; buffer name (if the buffer isn't visiting a file)
(setq frame-title-format
      '((:eval (if (buffer-file-name)
                   (abbreviate-file-name (buffer-file-name))
                 "%b"))))

;; other
(setq-default indent-tabs-mode nil)
(blink-cursor-mode 0)

;; set auto-scroll off in shell mode
(remove-hook 'comint-output-filter-functions
             'comint-postoutput-scroll-to-bottom)

;; hide minor modes emacs
(add-hook 'after-change-major-mode-hook 'clean-mode-line)

;; responsible white space
(add-hook 'before-save-hook 'whitespace-cleanup)
(add-hook 'before-save-hook 'clean-up-buffer-or-region)

(set-default 'indicate-empty-lines t)

;; Guide-mode
;; (setq guide-key/guide-key-sequence '("C-x r" "C-x 4" "C-x v" "C-x 8"))
;; (guide-key-mode 1)
;; (setq guide-key/recursive-key-sequence-flag t)
;; (setq guide-key/popup-window-position 'bottom)

(setq ring-bell-function 'ignore)
(setq column-number-mode 1)

;; clean GUI
(mapc
 (lambda (mode)
   (when (fboundp mode)
     (funcall mode -1)))
 '(menu-bar-mode tool-bar-mode scroll-bar-mode))

(setq inhibit-startup-message t inhibit-startup-echo-area-message t)

;; Setting up Unicode
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))

;;   Autosave settings
(defvar temporary-file-directory "/tmp/")

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))


;; --------------------------------------------------
;;;;;;;;;;;;;;;     C/C++     ;;;;;;;;;;;;;;;;;;;;
;; --------------------------------------------------

;; C/C++ mode settings
(setq-default c-basic-offset 4 c-default-style "linux")
;; (setq-default tab-width 4 indent-tabs-mode t)
(define-key c-mode-base-map (kbd "RET") 'newline-and-indent)
(setq mf--source-file-extension "cpp")
(add-hook 'c++-mode-hook '(lambda () (define-key python-mode-map "\C-m" 'newline-and-indent)))

;; Auto-complete
(add-hook 'c-mode-hook 'auto-complete-mode)
(add-hook 'c++-mode-hook 'auto-complete-mode)

;; Smartparens
(add-hook 'c++-mode-hook (lambda () (smartparens-mode 1)))
(add-hook 'c-mode-hook (lambda () (smartparens-mode 1)))

;; --------------------------------------------------
;;;;;;;;;;;;;;;     Java     ;;;;;;;;;;;;;;;;;;;;
;; --------------------------------------------------

(add-hook 'java-mode-hook 'auto-auto-indent-mode)
(setq-default c-basic-offset 4 c-default-style "linux")
;; (setq-default tab-width 4 indent-tabs-mode t)

;; Auto-complete
(add-hook 'java-mode-hook 'auto-complete-mode)

;; Smartparens
(add-hook 'java-mode-hook (lambda () (smartparens-mode 1)))


;; --------------------------------------------------
;;;;;;;;;;;;;;;     Python     ;;;;;;;;;;;;;;;;;;;;
;; --------------------------------------------------

(add-hook 'python-mode-hook '(lambda () (define-key python-mode-map "\C-m" 'newline-and-indent)))
(add-hook 'python-mode-hook 'auto-complete-mode)

;; Smartparens
(add-hook 'python-mode-hook (lambda () (smartparens-mode 1)))

;; --------------------------------------------------
;;;;;;;;;;;;;;;     Racket       ;;;;;;;;;;;;;;;;;;;;
;; --------------------------------------------------

;; Auto-complete
(add-hook 'racket-mode-hook 'auto-complete-mode)
(add-hook 'racket-repl-mode-hook 'auto-complete-mode)

;; Smartparens
(add-hook 'racket-mode-hook (lambda () (smartparens-mode 1)))
(add-hook 'racket-repl-mode-hook (lambda () (smartparens-mode 1)))

(add-hook 'racket-mode-hook
          (lambda ()
            (define-key racket-mode-map (kbd "C-c C-r") 'racket-send-region)
            (define-key racket-mode-map (kbd "C-x C-e") 'racket-send-definition)))


;; --------------------------------------------------
;;;;;;;;;;;;;;;;;;     Perl       ;;;;;;;;;;;;;;;;;;;
;; --------------------------------------------------

(defalias 'perl-mode 'cperl-mode)
(setq
 cperl-close-paren-offset -4
 cperl-continued-statement-offset 4
 cperl-indent-level 4
 cperl-indent-parens-as-block t
 cperl-tabs-always-indent t)



;; evil stuff

;; (use-package evil-mode
;;   :init
;;   (progn
;;     (evil-mode 1)
;;     (setq evil-escape-unordered-key-sequence 1)
;;     (setq-default evil-escape-delay 0.2)
;;     (add-hook 'comint-mode-hook
;;               (lambda ()
;;                 (define-key evil-normal-state-map "\C-p" 'comint-previous-input)))))


;; (use-package evil-surround
;;   :init (global-evil-surround-mode 1))


;; (use-package evil-escape
;;   :init
;;   (progn
;;     (setq-default evil-escape-key-sequence "jk")
;;     (evil-escape-mode 1)))


;; (use-package evil-leader
;;   :init
;;   (progn
;;  (evil-leader/set-leader "<SPC>")
;;  (global-evil-leader-mode)
;;  (evil-leader/set-key "e" 'find-file)
;;  ))


;; (use-package evil-smartparens
;;   :init
;;   (add-hook 'smartparens-enabled-hook #'evil-smartparens-mode))
