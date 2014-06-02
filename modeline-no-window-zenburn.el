;; modeline configuration

(setq-default
 mode-line-format
 '(
   "  "
   ;; current line number
   "("
   (:propertize "%4l," face mode-line-face)
   ;; current column number
   (:eval (propertize "%3c" 'face
					  (if (>= (current-column) 80)
						  'mode-line-80col-face
						'mode-line-face)
					  )
		  )
   ")"
   "  "
   ;; read-only or modified 
   (:eval
	(cond (buffer-read-only
		   (propertize " RO " 'face 'mode-line-read-only-face))
		  ((buffer-modified-p)
		   (propertize " ** " 'face 'mode-line-modified-face))
		  (t "    ")))
   "  "
   ;; sdirectory and buffer/file name
   (:propertize (:eval (shorten-directory default-directory 15)) face mode-line-folder-face)
   ;; name of buffer
   (:propertize "%b" face mode-line-filename-face)
   ;; name of open file
   ;;(:propertize "%f" face mode-line-read-only-face)
   "%n"
   "     "
   ;; mode indicators: vc, recursive edit, major mode, minor modes, process, global
   ;;(vc-mode vc-mode)
   "%["
   (:propertize mode-name face mode-line-mode-face)
   "%]"
   ;;(:eval (propertize (format-mode-line minor-mode-alist)
   ;;'face 'mode-line-minor-mode-face))

   ;;(:propertize mode-line-process face mode-line-process-face)
   (global-mode-string global-mode-string)
   "  "
   ;; nyan-mode uses nyan cat as an alternative to %
   ;;(:eval (list (nyan-create)))

   "["
   (:propertize "%p" face mode-line-mode-face)
   "/"
   (:propertize "%I" face mode-line-mode-face)
   "] "

   ;;"  "
   ;; date and times
   ;;(:eval (propertize (format-time-string "%2H : %2M") 'face 'mode-line-time-face 'help-echo (emacs-uptime "Uptime: %2h:%2m")))

   ))


(defun shorten-directory (dir max-length)
  "Show up to `max-length' characters of a directory name `dir'."
  (let ((path (reverse (split-string (abbreviate-file-name dir) "/")))
		(output ""))
	(when (and path (equal "" (car path)))
	  (setq path (cdr path)))
	(while (and path (< (length output) (- max-length 4)))
	  (setq output (concat (car path) "/" output))
	  (setq path (cdr path)))
	(when path
	  (setq output (concat ".../" output)))
	output))


(set-face-attribute 'mode-line nil
					:foreground "#EFEFAF"
					:background "#262626"
					:inverse-video nil
					:weight 'bold
					;;:box '(:line-width 3 :color "green" :style nil)
					:family "Ubuntu"
					)


(set-face-attribute 'mode-line-inactive nil
					:foreground "#EFEFAF"
					:background "#616161"
					:inverse-video nil
					:box '(:line-width 2 :color "white" :style nil)
					)

(make-face 'mode-line-80col-face)
(set-face-attribute 'mode-line-80col-face nil
					:inherit 'mode-line-face
					;;:foreground "white"
					:background "red"
					:weight 'bold
					)

(make-face 'mode-line-read-only-face)
(set-face-attribute 'mode-line-read-only-face nil
					:inherit 'mode-line-face
					;;:foreground "white"
					:background "red"
					:box '(:line-width 3 :color "red")
					:weight 'bold
					)

(make-face 'mode-line-modified-face)
(set-face-attribute 'mode-line-modified-face nil
					:inherit 'mode-line-face
					;;:foreground "white"
					:background "red"
					:box '(:line-width 3 :color "#c82829")
					)

(make-face 'mode-line-folder-face)
(set-face-attribute 'mode-line-folder-face nil
					:inherit 'mode-line-face
										;:background "#eab700"
					:foreground "#EFEFAF"
					:weight 'bold
					)

(make-face 'mode-line-filename-face)
(set-face-attribute 'mode-line-filename-face nil
					:inherit 'mode-line-face
					:background "red"
					:foreground "#EFEFAF"
					:weight 'bold
					:box '(:line-width 3 :color "red" )
					)

(make-face 'mode-line-time-face)
(set-face-attribute 'mode-line-time-face nil
					:inherit 'mode-line-face
					;;:background ""
					:foreground "#262626"
					:box '(:line-width 3 :color "gray20")
					:weight 'bold
					)

(make-face 'mode-line-mode-face)
(set-face-attribute 'mode-line-mode-face nil
					:inherit 'mode-line-face
					:foreground "#EFEFAF"
					;;:background "white"
					:box '(:line-width 3 :color "#262626" )
					:weight 'bold
					)

(make-face 'mode-line-minor-mode-face)
(set-face-attribute 'mode-line-minor-mode-face nil
					:inherit 'mode-line-mode-face
					:foreground "#EFEFAF"
					:weight 'bold
					)

(make-face 'mode-line-process-face)
(set-face-attribute 'mode-line-process-face nil
					:inherit 'mode-line-face
					:foreground "#EFEFAF"
					:weight 'bold
					)
