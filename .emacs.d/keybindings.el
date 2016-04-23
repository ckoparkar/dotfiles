;; Dont use this
(global-unset-key (kbd "<up>"))
(global-unset-key (kbd "<down>"))
(global-unset-key (kbd "<left>"))
(global-unset-key (kbd "<right>"))

;; Change ALT key seq
(global-set-key (kbd "C-x C-m") 'execute-extended-command)
(global-set-key (kbd "C-c C-m") 'execute-extended-command)

;; Avoid backspace
(global-set-key (kbd "C-w") 'backward-kill-word)
(global-set-key (kbd "C-x C-k") 'kill-region)
(global-set-key (kbd "C-c C-k") 'kill-region)

;; Better help functions

;; A quick major mode help with discover-my-major
(define-key 'help-command (kbd "C-m") 'discover-my-major)

(define-key 'help-command (kbd "C-f") 'find-function)
(define-key 'help-command (kbd "C-k") 'find-function-on-key)
(define-key 'help-command (kbd "C-v") 'find-variable)
(define-key 'help-command (kbd "C-l") 'find-library)

;; Extra navigation
(global-set-key (kbd "C-x g") 'goto-line)
(global-set-key (kbd "C-x e") 'end-of-buffer)
(global-set-key (kbd "C-x a") 'beginning-of-buffer)
(global-set-key (kbd "<C-return>") 'crux-smart-open-line)
(global-set-key (kbd "<S-return>") 'crux-smart-open-line-above)
(global-set-key [remap move-beginning-of-line] 'prelude-move-beginning-of-line)
(global-set-key (kbd "M-p") 'ace-window)

;; Magit
(key-chord-define-global "mg" 'magit-status)

;; Custom defuns
(global-set-key (kbd "C-x d") 'duplicate-line)
(global-set-key (kbd "M-;") 'comment-dwim-line)
(global-set-key (kbd "C-x ;") 'comment-or-uncomment-region)
(global-set-key (kbd "C-c C-g") 'google)
(global-set-key (kbd "C-c C-s") 'crux-swap-windows)
(global-set-key (kbd "C-c da") 'smartparens-dedent-all)

;; Enable smex, enhancement for M-x
(global-set-key (kbd "M-x")
                (lambda ()
                  (interactive)
                  (or (boundp 'smex-cache)
                      (smex-initialize))
                  (global-set-key (kbd "M-x") 'smex)
                  (smex)))

(global-set-key [(shift meta x)]
                (lambda ()
                  (interactive)
                  (or (boundp 'smex-cache)
                      (smex-initialize))
                  (global-set-key [(shift meta x)] 'smex-major-mode-commands)
                  (smex-major-mode-commands)))

(global-set-key (kbd "C-c C-m")
                (lambda ()
                  (interactive)
                  (or (boundp 'smex-cache)
                      (smex-initialize))
                  (global-set-key (kbd "C-c C-m") 'smex)
                  (smex)))

(global-set-key (kbd "C-x C-m")
                (lambda ()
                  (interactive)
                  (or (boundp 'smex-cache)
                      (smex-initialize))
                  (global-set-key (kbd "C-x C-m") 'smex)
                  (smex)))
