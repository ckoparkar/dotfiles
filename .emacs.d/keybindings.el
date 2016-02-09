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

;; multiple-cursors

(global-set-key (kbd "M->") 'mc/mark-next-like-this)
(global-set-key (kbd "M-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-x .") 'mc/mark-all-like-this)
(global-set-key (kbd "C-x /") 'mc/edit-lines)

(global-set-key (kbd "M-.") 'mc/unmark-next-like-this)
(global-set-key (kbd "M-,") 'mc/unmark-previous-like-this)

;; expand-region
(global-set-key (kbd "C-=") 'er/expand-region)

;; iy-go-to-char

(key-chord-define-global "fg" 'iy-go-to-char)
(key-chord-define-global "df" 'iy-go-to-char-backward)

;; ace-jump
(global-set-key (kbd "C-c SPC") 'ace-jump-mode)

;; Magit
(key-chord-define-global "mg" 'magit-status)

;; Easy transpose
(define-key evil-normal-state-map "\C-t" 'transpose-chars)

;;;; Commenting stuff

(defun comment-dwim-line (&optional arg)
  "Replacement for the comment-dwim command. If no region is selected and current line is not blank and we are not at the end of the line, then comment current line. Replaces default behaviour of comment-dwim, when it inserts comment at the end of the line."
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (comment-dwim arg)))

(global-set-key (kbd "M-;") 'comment-dwim-line)

(global-set-key (kbd "C-x ;") 'comment-or-uncomment-region)

(defun google (arg)
  "Googles a query or region if any.
With prefix argument, wrap search query in quotes."
  (interactive "P")
  (let ((query
         (if (region-active-p)
             (buffer-substring (region-beginning) (region-end))
           (read-string "Google: "))))
    (when arg (setq query (concat "\"" query "\"")))
    (browse-url
     (concat "http://www.google.com/search?ie=utf-8&oe=utf-8&q=" query))))

(global-set-key (kbd "C-c C-g") 'google)

(defun swap-windows ()
  "If you have 2 windows, it swaps them."
  (interactive)
  (cond ((/= (count-windows) 2)
         (message "You need exactly 2 windows to do this."))
        (t
         (let* ((w1 (first (window-list)))
                (w2 (second (window-list)))
                (b1 (window-buffer w1))
                (b2 (window-buffer w2))
                (s1 (window-start w1))
                (s2 (window-start w2)))
           (set-window-buffer w1 b2)
           (set-window-buffer w2 b1)
           (set-window-start w1 s2)
           (set-window-start w2 s1))))
  (other-window 1))

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
