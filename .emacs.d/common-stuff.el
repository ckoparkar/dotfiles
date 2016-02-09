;; (load-file "~/.emacs.d/rspec-mode/rspec-mode.el")
;; (load-file "~/.emacs.d/rutable/rutable.el")
;; (load-file "~/.emacs.d/emacs-rustfmt/rustfmt.el")

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
(require 'undo-tree)
(require 'inf-ruby)
(require 'rvm)
(require 'nyan-mode)
(require 'prodigy)
(require 'restclient)
(require 'magit)
(require 'restclient)
(require 'evil)
(require 'evil-surround)
(require 'evil-escape)
(require 'evil-leader)
(require 'linum-relative)

;; --------------------------------------------------
;;;;;;;;;;;;;;;     Preferences     ;;;;;;;;;;;;;;;;;
;; --------------------------------------------------


(cond
 ((memq window-system '(x))
  (load-theme 'default-black t)
  (set-face-attribute 'default nil :font "Monaco-12"))

 ((memq window-system '(mac ns))
  (load-theme 'default-black t)
  (exec-path-from-shell-initialize)
  (set-face-attribute 'default nil :font "Monaco-14"))

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

(global-linum-mode 1)
;; (linum-relative-on)

(projectile-global-mode)
(flx-ido-mode 1)
(ido-vertical-mode 1)

(key-chord-mode 1)

(setq evil-escape-unordered-key-sequence 1)
(setq-default evil-escape-delay 0.2)
(evil-leader/set-leader "<SPC>")
(global-evil-leader-mode)
(evil-leader/set-key
  "e" 'find-file)
(evil-escape-mode 1)
(setq-default evil-escape-key-sequence "jk")
(evil-mode 1)
(global-vim-empty-lines-mode)
(global-evil-surround-mode 1)

(blink-cursor-mode 0)

(delete-selection-mode 1)

;; set auto-scroll off in shell mode
(remove-hook 'comint-output-filter-functions
         'comint-postoutput-scroll-to-bottom)

;; hide minor modes emacs
(defvar mode-line-cleaner-alist
  `((auto-complete-mode . " ac")
    (projectile-mode " pm")
    (eldoc-mode . "")
    (abbrev-mode . "")
    (undo-tree-mode . "")
    (highlight-parentheses-mode . "")
    (magit-auto-revert-mode . "")
    (guide-key-mode . "")
    (smartparens-mode . "")

    ;; Major modes
    (lisp-interaction-mode . "λ")
    (clojure-mode . "λ")
    (haskell-mode . "λ")
    (python-mode . "Py")
    (emacs-lisp-mode . "λ"))
  "Alist for `clean-mode-line'.

When you add a new element to the alist, keep in mind that you
must pass the correct minor/major mode symbol and a string you
want to use in the modeline *in lieu of* the original.")

(defun clean-mode-line ()
  (interactive)
  (loop for cleaner in mode-line-cleaner-alist
    do (let* ((mode (car cleaner))
          (mode-str (cdr cleaner))
          (old-mode-str (cdr (assq mode minor-mode-alist))))
         (when old-mode-str
           (setcar old-mode-str mode-str))
         ;; major mode
         (when (eq mode major-mode)
           (setq mode-name mode-str)))))


(add-hook 'after-change-major-mode-hook 'clean-mode-line)

;; responsible white space
(add-hook 'before-save-hook 'whitespace-cleanup)

;; guide-mode
;; (setq guide-key/guide-key-sequence '("C-x r" "C-x 4" "C-x v" "C-x 8"))
;; (guide-key-mode 1)
;; (setq guide-key/recursive-key-sequence-flag t)
;; (setq guide-key/popup-window-position 'bottom)

;; magit mode
(setq magit-last-seen-setup-instructions "1.4.0")
(eval-after-load 'magit
  '(progn
     ;; (set-face-foreground 'magit-diff-add "green3")
     ;; (set-face-background 'magit-diff-add "#000012")
     ;; (set-face-foreground 'magit-diff-del "red3")
     ;; (set-face-background 'magit-diff-del "#000012")
     ;; (set-face-background 'magit-item-highlight "black")
     ))


;; markdown-mode
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(sml-modeline-mode)
(nyan-mode)

(yas-global-mode 1)
(global-auto-complete-mode t)
(global-pretty-mode 1)
(setq ring-bell-function 'ignore)
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
(defvar temporary-file-directory "/tmp/")

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


;; --------------------------------------------------
;;;;;;;;;;;;;;;     Python     ;;;;;;;;;;;;;;;;;;;;
;; --------------------------------------------------

(add-hook 'python-mode-hook '(lambda () (define-key python-mode-map "\C-m" 'newline-and-indent)))
(add-hook 'python-mode-hook 'auto-complete-mode)

;; Smartparens
(add-hook 'python-mode-hook (lambda () (smartparens-mode 1)))


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

;; inf-ruby
(autoload 'inf-ruby-minor-mode "inf-ruby" "Run an inferior Ruby process" t)
(add-hook 'ruby-mode-hook 'inf-ruby-minor-mode)

;; use rvm
(add-hook 'ruby-mode-hook
      (lambda () (rvm-activate-corresponding-ruby)))

;; Flycheck
;; (add-hook 'ruby-mode-hook 'flycheck-mode)

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
(add-hook 'lisp-interaction-mode-hook (lambda () (setq-default indent-tabs-mode nil)))


;; Autocomplete
(add-hook 'emacs-lisp-mode-hook 'auto-complete-mode)

;; --------------------------------------------------
;;;;;;;;;;;;;;;        Go        ;;;;;;;;;;;;;;;;;;;;
;; --------------------------------------------------

;; require to make goimports work.
(add-to-list 'exec-path "~/chai/go/bin")

(defun csk-go-mode-hooks ()
  (setq gofmt-command "goimports")
  (setq tab-width 8 indent-tabs-mode 1)
  (add-hook 'before-save-hook 'gofmt-before-save))

(add-hook 'go-mode-hook 'csk-go-mode-hooks)
(add-hook 'go-mode-hook (lambda () (smartparens-mode 1)))
(add-hook 'go-mode-hook 'auto-complete-mode)

;; --------------------------------------------------
;;;;;;;;;;;;;;;        Rust        ;;;;;;;;;;;;;;;;;;
;; --------------------------------------------------

(add-hook 'rust-mode-hook #'rustfmt-enable-on-save)
(add-hook 'rust-mode-hook 'auto-complete-mode)
(add-hook 'rust-mode-hook (lambda () (smartparens-mode 1)))

;; --------------------------------------------------
;;;;;;;;;;;;;;;      Haskell    ;;;;;;;;;;;;;;;;;;;;;
;; --------------------------------------------------

(add-hook 'haskell-mode-hook 'auto-complete-mode)
(add-hook 'haskell-mode-hook (lambda () (smartparens-mode 1)))

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
;;;;;;;;;;;;;;;     Javascript       ;;;;;;;;;;;;;;;;
;; --------------------------------------------------

(add-hook 'js-mode-hook 'js2-minor-mode)
(add-hook 'js2-mode-hook 'ac-js2-mode)

;; Auto-complete
(add-hook 'js2-mode-hook 'auto-complete-mode)

;; Smartparens
(add-hook 'js2-mode-hook (lambda () (smartparens-mode 1)))

;; Highlight all js keywords
(setq js2-highlight-level 3)

;; jshint
(add-hook 'js2-mode-hook
      (lambda () (flycheck-mode t)))

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

;; --------------------------------------------------
;;;;;;;;;;;;;;;;;;     Restclient       ;;;;;;;;;;;;;
;; --------------------------------------------------

(add-to-list 'auto-mode-alist '("\\.rest\\'" . restclient-mode))
