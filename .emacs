;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; File name: ` ~/.emacs '
;;; ---------------------
;;;
;;; If you need your own personal ~/.emacs
;;; please make a copy of this file
;;; an placein your changes and/or extension.
;;;
;;; Copyright (c) 1997-2002 SuSE Gmbh Nuernberg, Germany.
;;;
;;; Author: Werner Fink, <feedback@suse.de> 1997,98,99,2002
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Test of Emacs derivates
;;; -----------------------
(if (string-match "XEmacs\\|Lucid" emacs-version)
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;; XEmacs
  ;;; ------
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (progn
     (if (file-readable-p "~/.xemacs/init.el")
        (load "~/.xemacs/init.el" nil t))
  )
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;; GNU-Emacs
  ;;; ---------
  ;;; load ~/.gnu-emacs or, if not exists /etc/skel/.gnu-emacs
  ;;; For a description and the settings see /etc/skel/.gnu-emacs
  ;;;   ... for your private ~/.gnu-emacs your are on your one.
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (if (file-readable-p "~/.gnu-emacs")
      (load "~/.gnu-emacs" nil t)
    (if (file-readable-p "/etc/skel/.gnu-emacs")
	(load "/etc/skel/.gnu-emacs" nil t)))

  ;; Custum Settings
  ;; ===============
  ;; To avoid any trouble with the customization system of GNU emacs
  ;; we set the default file ~/.gnu-emacs-custom
  (setq custom-file "~/.gnu-emacs-custom")
  (load "~/.gnu-emacs-custom" t t)
;;;
)
(setq load-path (append (list "~/emacs/") load-path))

;; setup frame defaults
(setq default-frame-alist
      '((top . 15) (left . 5)
        (width . 150) (height . 160)
        (cursor-color . "red")
        (cursor-type . box)
        (foreground-color . "white")
        (background-color . "black")
        (font . "8x13")
;; 		  (font . "-*-fixed-medium-r-*--10-*-*-*-*-*-fontset-12")
;;        (font . "-*-Terminal-normal-r-*-*-*-90-*-*-c-80-*-oem")
;;        (font . "-*-Lucida Sans Typewriter-normal-r-*-*-12-*-*-*-c-*-iso8859-1")
;;        (font . "-*-Courier-normal-r-*-*-12-*-*-*-c-*-iso8859-1")
;; 		  (font . "-*-Lucida Console-normal-r-*-*-11-*-*-*-c-*-iso8859-1")
		))

;;;

(setq-default c-basic-offset 4
			  tab-width 4
			  indent-tabs-mode t)
(setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108 112 116 120))
(set-default 'truncate-lines t)
(tool-bar-mode -1)
(which-function-mode t)
(setq read-quoted-char-radix 16)
(prefer-coding-system 'utf-8-unix)
(require 'php-mode)
(require 'xcscope)
(require 'vc-hg )
(require 'tty-format)
(require 'markerpen)
(require 'multi-web-mode)
(setq mweb-default-major-mode 'html-mode)
(setq mweb-tags '((php-mode "<\\?php\\|<\\? \\|<\\?=" "\\?>")
(js-mode "<script[^>]*>" "</script>")
(css-mode "<style[^>]*>" "</style>")))
(setq mweb-filename-extensions '("php" "htm" "html" "ctp" "phtml" "php4" "php5"))
(multi-web-global-mode 1)
;;
(put 'upcase-region 'disabled nil)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(c-default-style (quote ((c-mode . "linux") (java-mode . "java") (awk-mode . "awk") (other . "linux"))))
 '(tab-width 4)
 '(grep-find-command "find $DIR__BUILD_ROOT/project/$MODULE__NAME/source -print0 | xargs -0 -e grep -n -e ")
; -type f ! \\( -path '*/.svn/*' -o -path '*/.hg/*' -o -name '*.svn-base' -o -name 'TAGS' -o -name '*.[oad]' -o -name '*.xml' -o -name '*.html' -o -name '*[#~]' -o -name '*.map' -o -name '*.elf' -o -name '*.gz' -o -name '*.orig' -o -name '*.zip' -o -name '*.pj' -o -name '*.use' -o -path '*/vivaldi/*' -o -path '*/koala/*' -o -path '*/brad/*' -o -path '*/linux/*' \\) -print0 | xargs -0 -e grep -n -e ")
 '(current-language-environment "UTF-8")
 '(read-quoted-char-radix 16)
 '(cscope-initial-directory "~/cscope/project/")
 '(c-offsets-alist (quote ((case-label . +) (substatement . 0))))
 '(gud-gdb-command-name "~/bin/gdbProj --annotate=3")
 '(vc-hg-log-switches "-l10"))

;; '(vc-hg-global-switches (quote ("--style default")))

(setq ediff-split-window-function 'split-window-horizontally)

(defun command-line-diff (switch)
  (let ((file1 (pop command-line-args-left))
		(file2 (pop command-line-args-left)))
	(ediff file1 file2)))
    
(add-to-list 'command-switch-alist '("diff" . command-line-diff))
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; dos2unix from Benjamin Rutt's .emacs
(defun dos2unix () (interactive)
  (goto-char (point-min))
  (while (search-forward "\r" nil t) (replace-match "")))

;; unix2dos from Benjamin Rutt's .emacs
(defun unix2dos () (interactive)
  (goto-char (point-min))
  (while (search-forward "\n" nil t) (replace-match "\r\n")))

(global-set-key [f2]  'ediff-buffers)
(global-set-key [f12] 'compile)
(global-set-key [f11] 'recompile)
(global-set-key [f10] 'gdb-many-windows)

(put 'downcase-region 'disabled nil)

(setq load-home-init-file t) ; don't load init file from ~/.xemacs/init.el
(server-start)
