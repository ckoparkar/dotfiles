(require 'package)
(add-to-list 'package-archives
             '("marmalade" .
               "http://marmalade-repo.org/packages/"))

(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)

(package-initialize)

(require 'cask "~/.cask/cask.el")
(cask-initialize)

(set-default-font "DejavuSansMono 11")

(load-file "~/.emacs.d/common-stuff.el")
(load-file "~/.emacs.d/keybindings.el")
(if (not window-system)
  (progn (load-file "~/.emacs.d/modeline-no-window.el")
  (load-theme 'zenburn t))
  )
