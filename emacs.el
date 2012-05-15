;; Remove splash screen
(setq inhibit-splash-screen t)
(setq inhibit-startup-echo-area-message t)
(setq inhibit-startup-message t)
(require 'package)
(package-initialize)
;; Evil =============================================================================
(require 'evil)
;;http://dnquark.com/blog/2012/02/emacs-evil-ecumenicalism/
(evil-mode 1)
(setq evil-default-state 'normal)
(define-key global-map [f3] 'buffer-menu)
(define-key evil-insert-state-map (kbd "C-w") 'evil-window-map)
(define-key evil-insert-state-map (kbd "C-w <left>") 'evil-window-left)
(define-key evil-insert-state-map (kbd "C-w <right>") 'evil-window-right)
(define-key evil-insert-state-map (kbd "C-w <up>") 'evil-window-up)
(define-key evil-insert-state-map (kbd "C-w <down>") 'evil-window-down)
(define-key evil-normal-state-map (kbd "`") 'find-file)
;;(define-key global-map (kbd "`") 'find-file)
(evil-define-command "Ve" (function 
                            lambda() (split-window-horizontally)))
(defun vex ()
  (interactive)
  (split-window-horizontally))

;; Dired =============================================================================
(require 'dired+)
;;(require 'dired-single)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (defun my-dired-init ()                                                    ;;
;; "Bunch of stuff to run for dired, either immediately or when it's loaded." ;;
;; ;; <add other stuff here>                                                  ;;
;; (lambda() (dired-omit-mode 1))                                                  ;;
;; (setq dired-omit-files "^\\...+$")                                         ;;
;; (setq dired-listing-switches "-lXGh --group-directories-first")            ;;
;; (define-key dired-mode-map [f3] 'buffer-menu)                              ;;
;; (define-key dired-mode-map [return] 'joc-dired-single-buffer)              ;;
;; (define-key dired-mode-map [mouse-1] 'joc-dired-single-buffer-mouse)       ;;
;; (define-key dired-mode-map [(f3)] 'buffer-menu)                            ;;
;; (define-key dired-mode-map (kbd "-") 'dired-up-directory))                 ;;
;; (suppress-keymap dired-mode-map)                                           ;;
;;        (define-key dired-mode-map "r" 'dired-rename-file)                  ;;
;; (define-key dired-mode-map  (kbd ":") 'evil-ex)                            ;;
;; (define-key dired-mode-map "^"                                             ;;
;;  (function                                                                 ;;
;;   (lambda () (joc-dired-single-buffer ".."))))                                  ;;
;; (define-key dired-mode-map "-"                                             ;;
;;  (function                                                                 ;;
;;   (lambda nil () (joc-dired-single-buffer "..")))))                             ;;
;;                                                                            ;;
;; if dired's already loaded, then the keymap will be bound                   ;;
;; (if (boundp 'dired-mode-map)                                               ;;
;;     we're good to go; just add our bindings                                ;;
;;     (my-dired-init)                                                        ;;
;;                                                                            ;;
;;   it's not loaded yet, so add our bindings to the load-hook                ;;
;;   (add-hook 'dired-load-hook 'my-dired-init))                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global-set-key (kbd "M-o s") 'dired)
(global-set-key (kbd "M-o r") 'buffer-menu)
(global-set-key (kbd "<escape>")      'keyboard-escape-quit)
(define-key dired-mode-map [f3] 'buffer-menu)                              ;;
;;(define-key dired-mode-map "M-o r" 'buffer-menu)
(define-key dired-mode-map "-" 'dired-up-directory)
(toggle-diredp-find-file-reuse-dir 1)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;(global-set-key [(f4)] 'joc-dired-magic-buffer)
;;(global-set-key [f4] 'joc-dired-magic-buffer) ;;'dired)
;; (global-set-key [(control f4)] (function                          ;;
;;         (lambda nil (interactive)                                      ;;
;;         (joc-dired-magic-buffer default-directory))))             ;;
;; (global-set-key [(shift f4)] (function                            ;;
;;         (lambda nil (interactive)                                      ;;
;;         (message "Current directory is: %s" default-directory)))) ;;
;; (global-set-key [(meta f4)] 'joc-dired-toggle-buffer-name)        ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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
;;(load-theme "tango-2-steven")

;; Python Mode ================================================================================ 
;;(autoload 'python-mode "python-mode.el" "Python mode." t)
;;(setq auto-mode-alist (append '(("/*.\.py$" . python-mode)) auto-mode-alist))
;;;;http://emacs-fu.blogspot.com.au/2008/12/showing-and-hiding-blocks-of-code.html
;;(add-hook 'python-mode-hook
;;      #'(lambda ()
;;    (local-set-key (kbd "C-c <right>") 'hs-show-block)
;;    (local-set-key (kbd "C-c <left>")  'hs-hide-block)
;;    (local-set-key (kbd "C-c <up>")    'hs-hide-all)
;;    (local-set-key (kbd "C-c <down>")  'hs-show-all)
;;    (hs-minor-mode t)
;;    (hs-hide-all)
;;          (setq autopair-handle-action-fns
;;            (list #'autopair-default-handle-action
;;              #'autopair-python-triple-quote-action))))
;;======= Code folding =======
(defun jao-toggle-selective-display ()
  (interactive)
  (set-selective-display (if selective-display nil 1)))

;;(global-set-key [(f1)] 'jao-toggle-selective-display)
(define-key global-map (kbd "M-o p") 'jao-toggle-selective-display)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes nil)
 '(ediff-split-window-function (quote split-window-horizontally))
 '(custom-safe-themes (quote ("1797bbff3860a9eca27b92017b96a0df151ddf2eb5f73e22e37eb59f0892115e" "21d9280256d9d3cf79cbcf62c3e7f3f243209e6251b215aede5026e0c5ad853f" default))))
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
(load-file "~/.emacs.d/Pymacs/pymacs.el")
(require 'pymacs)
(pymacs-load "ropemacs" "rope-")

