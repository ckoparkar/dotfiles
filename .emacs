(require 'package)
(add-to-list 'package-archives
             '("marmalade" .
               "http://marmalade-repo.org/packages/"))
(package-initialize)

(load-file "~/.emacs.d/common-stuff.el")
(load-file "~/.emacs.d/keybindings.el")

(if window-system
	(load-file "~/.emacs.d/modeline-window.el")
	(load-file "~/.emacs.d/modeline-no-window.el")
	)
