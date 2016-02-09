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

;; Fix backspace
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "C-?") 'help-command)

;; Extra navigation
(global-set-key (kbd "C-x g") 'goto-line)
(global-set-key (kbd "C-x e") 'end-of-buffer)
(global-set-key (kbd "C-x a") 'beginning-of-buffer)

(global-set-key (kbd "C-x d") 'duplicate-line)

;; evil-mode deprecates this
;; ;; iy-go-to-char

;; (key-chord-define-global "fg" 'iy-go-to-char)
;; (key-chord-define-global "df" 'iy-go-to-char-backward)

;; ace-jump
(global-set-key (kbd "C-c SPC") 'ace-jump-mode)

;; Magit
(key-chord-define-global "mg" 'magit-status)

;; Easy transpose
;; (define-key evil-normal-state-map "\C-t" 'transpose-chars)

;;;; Commenting stuff

(global-set-key (kbd "M-;") 'comment-dwim-line)

(global-set-key (kbd "C-x ;") 'comment-or-uncomment-region)

(global-set-key (kbd "C-c C-g") 'google)

(global-set-key (kbd "C-c C-s") 'swap-windows)

;;; smaertparens traverse

(global-set-key (kbd "M-]") 'sp-next-sexp)
(global-set-key (kbd "M-[") 'sp-previous-sexp)

(global-set-key (kbd "M-}") 'sp-down-sexp)
(global-set-key (kbd "M-{") 'sp-up-sexp)

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
