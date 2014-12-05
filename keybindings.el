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


;; Duplicate line
(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (newline)
  (yank)
  )

(global-set-key (kbd "C-x d") 'duplicate-line)

;;;; Multiple Cursors ;;;;;

(global-set-key (kbd "M->") 'mc/mark-next-like-this)
(global-set-key (kbd "M-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-x .") 'mc/mark-all-like-this)
(global-set-key (kbd "C-x /") 'mc/edit-lines)

(global-set-key (kbd "M-.") 'mc/unmark-next-like-this)
(global-set-key (kbd "M-,") 'mc/unmark-previous-like-this)


;; iy-go-to-char

(key-chord-define-global "fg" 'iy-go-to-char)
(key-chord-define-global "df" 'iy-go-to-char-backward)

;; ace-jump
(global-set-key (kbd "C-c SPC") 'ace-jump-mode)

;; Magit
(key-chord-define-global "mg" 'magit-status)

;;;; Commenting stuff

(defun comment-dwim-line (&optional arg)
  "Replacement for the comment-dwim command.
        If no region is selected and current line is not blank and we are not at the end of the line, then comment current line.
        Replaces default behaviour of comment-dwim, when it inserts comment at the end of the line."
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
	  (comment-or-uncomment-region (line-beginning-position) (line-end-position))
	(comment-dwim arg)))

(global-set-key (kbd "M-;") 'comment-dwim-line)

(global-set-key (kbd "C-x ;") 'comment-or-uncomment-region)

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
