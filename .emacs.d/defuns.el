;; defuns.el
;;
;; Exports custom utility functions


(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (newline)
  (yank)
  )


(defun comment-dwim-line (&optional arg)
  "Replacement for the comment-dwim command. If no region is selected and current line is not blank and we are not at the end of the line, then comment current line. Replaces default behaviour of comment-dwim, when it inserts comment at the end of the line."
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
	  (comment-or-uncomment-region (line-beginning-position) (line-end-position))
	(comment-dwim arg)))


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


(defvar mode-line-cleaner-alist
  `((auto-complete-mode . " ac")
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



(provide 'defuns)
;;; defuns.el ends here
