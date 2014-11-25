(require 'package)
(add-to-list 'package-archives
             '("marmalade" .
               "http://marmalade-repo.org/packages/"))

(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)

(package-initialize)

(defun ensure-package-installed (&rest packages)
  "Assure every package is installed, ask for installation if it’s not.

Return a list of installed packages or nil for every skipped package."
  (mapcar
   (lambda (package)
     ;; (package-installed-p 'evil)
     (if (package-installed-p package)
         nil
       (if (y-or-n-p (format "Package %s is missing. Install it? " package))
           (package-install package)
         package)))
   packages))

;; make sure to have downloaded archive description.
;; Or use package-archive-contents as suggested by Nicolas Dudebout
(or (file-exists-p package-user-dir)
    (package-refresh-contents))

(ensure-package-installed 'auto-complete
						  'ido
						  'rainbow-delimiters
						  'cc-mode
						  'paredit
						  'multiple-cursors
						  'dash
						  'pkg-info
						  'clojure-mode
						  'epl
						  'cider
						  'ac-cider
						  'yasnippet
						  'pretty-mode-plus
						  'color-theme
						  'highlight-parentheses
						  'smex
						  'sml-modeline
						  's
						  'clj-refactor
						  'xclip
						  'smartparens
						  'iy-go-to-char
						  'zenburn-theme
						  'auto-auto-indent
						  'inf-ruby
						  'lua-mode
						  'projectile
						  'key-chord)

;; activate installed packages
(package-initialize)

(set-default-font "DejavuSansMono 11")

(load-file "~/.emacs.d/common-stuff.el")
(load-file "~/.emacs.d/keybindings.el")
(if window-system
	(load-theme 'hickey t)
  (progn (load-file "~/.emacs.d/modeline-no-window.el")
  (load-theme 'zenburn t))
  )
