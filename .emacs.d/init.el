(require 'package)
(add-to-list 'package-archives
             '("marmalade" .
               "http://marmalade-repo.org/packages/"))

(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)

(package-initialize)

(require 'cask "~/.cask/cask.el")
(cask-initialize)

;; Setup load path
(add-to-list 'load-path "/Users/chaitanya/.emacs.d/site-lisp/cider")
(add-to-list 'load-path "/Users/chaitanya/.emacs.d/site-lisp/clj-refactor.el")

(require 'cider)
(require 'clj-refactor)
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
(use-package company
  :config (global-company-mode))

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

(use-package crux)

(use-package key-chord)

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

(use-package inf-ruby
  :init (add-hook 'ruby-mode-hook 'inf-ruby-minor-mode))

(use-package rvm
  :init (add-hook 'ruby-mode-hook (lambda () (rvm-activate-corresponding-ruby))))

(use-package flycheck)

(use-package elisp-slime-nav
  :config
  (progn
    (dolist (hook '(emacs-lisp-mode-hook ielm-mode-hook))
      (add-hook hook 'elisp-slime-nav-mode))))

(use-package easy-kill
  :config
  (global-set-key [remap kill-ring-save] 'easy-kill))

(use-package ace-window
  :config
  (progn
    (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))))

;; better looking

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
    (setq ido-auto-merge-work-directories-length nil)
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

(use-package eldoc
  :init
  (progn
    (add-hook 'emacs-lisp-mode-hook (lambda () (eldoc-mode 1)))))

;; managing parens

(use-package smartparens
  :init
  (progn
    (smartparens-global-strict-mode 1)
    (smartparens-global-mode 1)
    (sp-pair "'" nil :actions :rem)
    (sp-pair "`" nil :actions :rem)
    (dolist (hook '(cider-repl-mode-hook
                    clojure-mode-hook
                    emacs-lisp-mode-hook
                    list-mode-hook
                    list-interaction-mode-hook
                    go-mode-hook
                    ruby-mode-hook
                    rust-mode-hook
                    haskell-mode-hook
                    js2-mode-hook))
      (add-hook hook (lambda () (smartparens-mode 1))))))

;; clojure utils

(use-package cider
  :config
  (progn
    (add-hook 'cider-mode-hook 'eldoc-mode)
    (add-hook 'cider-repl-mode-hook #'eldoc-mode)
    (setq nrepl-hide-special-buffers t)
    (setq cider-repl-pop-to-buffer-on-connect nil)
    (setq cider-popup-stacktraces nil)
    (define-key cider-repl-mode-map (kbd "M-p") 'cider-repl-backward-input)
    (define-key cider-repl-mode-map (kbd "M-n") 'cider-repl-forward-input))
  :bind (("C-c r". cider-repl-reset)))

(use-package clj-refactor
  :init
  (progn
    (add-hook 'clojure-mode-hook
              (lambda ()
                (clj-refactor-mode 1)
                (cljr-add-keybindings-with-prefix "C-c C-m")))))

(use-package 4clojure)

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
      (setq gofmt-command "goimports")
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

;; remap right-command key to alt in mac
(setq ns-right-command-modifier 'meta)

;; 80 columns is wide enough
;; http://stackoverflow.com/questions/18855510/have-emacs-highlight-characters-over-80/18855782#18855782
(require 'whitespace)
(setq whitespace-line-column 80) ;; limit line length
(setq whitespace-style '(face lines-tail))
(add-hook 'prog-mode-hook 'whitespace-mode)

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
