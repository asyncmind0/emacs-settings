;; Remove splash screen
;;(add-to-list 'load-path
;;                     "~/.emacs.d/ecb/")

;;(load-file "/usr/share/emacs/site-lisp/cedet/common/cedet.el")
;;(require 'ecb)

(setq stack-trace-on-error t)
(setq inhibit-splash-screen t)
(setq inhibit-startup-echo-area-message t)
(setq inhibit-startup-message t)
(setq paredit-mode 0)
(require 'package)
(package-initialize)
(require 'xclip)
(require 'uniquify)
(setq uniqueify-buffer-name-style 'reverse)

;; CScope =============================================================================
(require 'xcscope)
;; Evil =============================================================================
(require 'evil)
(require 'evil-search)
;;http://dnquark.com/blog/2012/02/emacs-evil-ecumenicalism/
(evil-mode 1)
(setq evil-default-state 'normal)
(setq evil-flash-delay 60)
(define-key global-map [f3] 'buffer-menu)
(define-key evil-insert-state-map (kbd "C-w") 'evil-window-map)
(define-key evil-insert-state-map (kbd "C-w <left>") 'evil-window-left)
(define-key evil-insert-state-map (kbd "C-w <right>") 'evil-window-right)
(define-key evil-insert-state-map (kbd "C-w <up>") 'evil-window-up)
(define-key evil-insert-state-map (kbd "C-w <down>") 'evil-window-down)
(define-key evil-normal-state-map (kbd "`") 'find-file)
(define-key evil-normal-state-map (kbd "C-]") 'cscope-find-global-definition-no-prompting)
(evil-define-key 'normal evil-normal-state-map "C-c d" 'cscope-find-symbol)
(define-key evil-normal-state-map (kbd "C-t") 'cscope-pop-mark)
;;(define-key global-map (kbd "`") 'find-file)
(evil-define-command "Ve" (function 
                            lambda() (split-window-horizontally)))
(defun vex ()
  (interactive)
  (split-window-horizontally))

;; Dired =============================================================================
(require 'dired+)
(global-set-key (kbd "M-o s") 'dired)
(global-set-key (kbd "M-o r") 'buffer-menu)
(global-set-key (kbd "<escape>")      'keyboard-escape-quit)
(define-key dired-mode-map [f3] 'buffer-menu)                              ;;
(define-key dired-mode-map (kbd "-") 'dired-up-directory)
(toggle-diredp-find-file-reuse-dir 1)
;;Recent Files===========================================================================
(require 'recentf)
(recentf-mode 1)
 (defun recentf-open-files-compl ()
      (interactive)
      (let* ((all-files recentf-list)
        (tocpl (mapcar (function 
           (lambda (x) (cons (file-name-nondirectory x) x))) all-files))
        (prompt (append '("File name: ") tocpl))
        (fname (completing-read (car prompt) (cdr prompt) nil nil)))
        (find-file (cdr (assoc-ignore-representation fname tocpl))))) 
;;(global-set-key "\C-x\C-r" 'recentf-open-files-compl)
(global-set-key "\C-x\C-r" 'recentf-open-files)

;;Menu Bar ===========================================================================
(menu-bar-mode 0)
(setq mode-line-format
          (list
           ;; value of `mode-name'
           "%m: "
           ;; value of current buffer name
           "buffer %b, "
           ;; value of current line number
           "line %l "
           "-- user: "
           ;; value of user
           (getenv "USER")))

;:q; Color Themes ================================================================================ 
(load-file "~/.emacs.d/tango-2-steven-theme.el")
;(load-file "~/.emacs.d/color-theme-cool-dark.el")
;;(load-theme "tango-2-steven")

;; Python Mode ================================================================================ 
;;(autoload 'python-mode "python-mode.el" "Python mode." t)
;;(setq auto-mode-alist (append '(("/*.\.py$" . python-mode)) auto-mode-alist))
;;;;http://emacs-fu.blogspot.com.au/2008/12/showing-and-hiding-blocks-of-code.html
(add-hook 'python-mode-hook
      #'(lambda ()
    (local-set-key (kbd "C-c <right>") 'hs-show-block)
    (local-set-key (kbd "C-c <left>")  'hs-hide-block)
    (local-set-key (kbd "C-c <up>")    'hs-hide-all)
    (local-set-key (kbd "C-c <down>")  'hs-show-all)
    (local-set-key (kbd "C-]")  'cscope-find-symbol)
    ;;(hs-minor-mode t)
    ;;(hs-hide-all)
    ;;(setq autopair-handle-action-fns
      ;;(list #'autopair-default-handle-action
        ;;  #'autopair-python-triple-quote-action
    ))
;;======= Code folding =======
(defun jao-toggle-selective-display ()
  (interactive)
  (set-selective-display (if selective-display nil 1)))

;;(global-set-key [(f1)] 'jao-toggle-selective-display)
;;(define-key global-map (kbd "M-o p") 'jao-toggle-selective-display)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ack-and-a-half-prompt-for-directory t)
 '(compilation-disable-input t)
 '(cscope-do-not-update-database t)
 '(custom-enabled-themes (quote (tango-2-steven)))
 '(custom-safe-themes (quote ("3800c684fc72cd982e3366a7c92bb4f3975afb9405371c7cfcbeb0bee45ddd18" "7c66e61cada84d119feb99a90d30da44fddc60f386fca041c01de74ebdd934c2" "f41ff26357e8ad4d740901057c0e2caa68b21ecfc639cbc865fdd8a1cb7563a9" "1797bbff3860a9eca27b92017b96a0df151ddf2eb5f73e22e37eb59f0892115e" "21d9280256d9d3cf79cbcf62c3e7f3f243209e6251b215aede5026e0c5ad853f" default)))
 '(ecb-options-version "2.40")
 '(ecb-source-path (quote ("/home/steven/iress/xplan/")))
 '(ediff-split-window-function (quote split-window-horizontally))
 '(grep-command "ack --with-filename --nogroup --all")
 '(lazy-highlight-cleanup nil)
 '(lazy-highlight-initial-delay 0)
 '(lazy-highlight-max-at-a-time nil)
 '(paredit-mode nil t)
 '(recentf-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
; define function to shutdown emacs server instance
(defun server-shutdown ()
  "Save buffers, Quit, and Shutdown (kill) server"
  (interactive)
  (save-some-buffers)
  (kill-emacs))
 
;; python ropemacs and pyemacs
;;https://github.com/mzc/ropemacs

(add-to-list 'load-path "~/.emacs.d/")
(autoload 'ack-and-a-half-same "ack-and-a-half" nil t)
(autoload 'ack-and-a-half "ack-and-a-half" nil t)
(autoload 'ack-and-a-half-find-file-same "ack-and-a-half" nil t)
(autoload 'ack-and-a-half-find-file "ack-and-a-half" nil t)
;; Create shorter aliases
(defalias 'ack 'ack-and-a-half)
(defalias 'ack-same 'ack-and-a-half-same)
(defalias 'ack-find-file 'ack-and-a-half-find-file)
(defalias 'ack-find-file-same 'ack-and-a-half-find-file-same)
;;grep window
(setq split-width-threshold nil)
(defun my-grep ()
  "Run grep and resize the grep window"
  (interactive)
  (progn
    (call-interactively 'grep)
    (setq cur (selected-window))
    (setq w (get-buffer-window "*grep*"))
    (select-window w)
    (setq h (window-height w))
    (shrink-window (- h 15))
    (select-window cur)
    )
  )
(defun my-grep-hook () 
  "Make sure that the compile window is splitting vertically"
  (progn
    (if (not (get-buffer-window "*grep*"))
       (progn
      (split-window-vertically)))))
(add-hook 'grep-mode-hook 'my-grep-hook)
(global-set-key [f6] 'my-grep)

(load-file "~/.emacs.d/Pymacs/pymacs.el")
(require 'pymacs)
(pymacs-load "ropemacs" "rope-")
;; code to insert word under point into minibuffer
;;http://stackoverflow.com/questions/8257009/emacs-insert-word-at-point-into-replace-string-query
(defun my-minibuffer-insert-word-at-point ()
  "Get word at point in original buffer and insert it to minibuffer."
  (interactive)
  (let (word beg)
    (with-current-buffer (window-buffer (minibuffer-selected-window))
      (save-excursion
        (skip-syntax-backward "w_")
        (setq beg (point))
        (skip-syntax-forward "w_")
        (setq word (buffer-substring-no-properties beg (point)))))
    (when word
      (insert word))))

(defun my-minibuffer-setup-hook ()
  (local-set-key (kbd "C-w") 'my-minibuffer-insert-word-at-point))

;;(add-hook 'minibuffer-setup-hook 'my-minibuffer-setup-hook)

(defun reload-emacs-config ()
  "reload emacs config"
  (interactive)
  (load-file "~/.emacs"))

(defun edit-emacs-config ()
  (interactive)
  (find-file "~/.emacs.d/emacs.el"))


;; ediff cleanup 
(defvar my-ediff-bwin-config nil "Window configuration before ediff.")
(defcustom my-ediff-bwin-reg ?b
  "*Register to be set up to hold `my-ediff-bwin-config'
    configuration.")

(defun my-ediff-bsh ()
  "Function to be called before any buffers or window setup for
    ediff."
  (remove-hook 'ediff-quit-hook 'ediff-cleanup-mess)
  (window-configuration-to-register my-ediff-bwin-reg))

(defun my-ediff-aswh ()
"setup hook used to remove the `ediff-cleanup-mess' function.  It causes errors."
  (remove-hook 'ediff-quit-hook 'ediff-cleanup-mess))

(defun my-ediff-qh ()
  "Function to be called when ediff quits."
  (remove-hook 'ediff-quit-hook 'ediff-cleanup-mess)
  (ediff-cleanup-mess)
  (jump-to-register my-ediff-bwin-reg))

(add-hook 'ediff-before-setup-hook 'my-ediff-bsh)
(add-hook 'ediff-after-setup-windows-hook 'my-ediff-aswh);
(add-hook 'ediff-quit-hook 'my-ediff-qh)
