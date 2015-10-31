(global-set-key [f12] (lambda () (interactive) (find-file "~/.emacs.d/init.el")))
(global-set-key [f11] (lambda () (interactive) (find-file "~/clojure/clojure-noob/src/clojure_noob/core.clj")))
(global-set-key [f10] (lambda () (interactive) (find-file "~/cljs/reagent/myfirst/src/cljs/myfirst/core.cljs")))
(global-set-key [f10] (lambda () (interactive) (find-file "~/cljs/reagent")))
(global-set-key [f8] (lambda () (interactive) (cider-jack-in)))
(global-set-key [f1] (lambda () (interactive) (switch-to-previous-buffer)))

;; simple buffer switching trick
(defun switch-to-previous-buffer ()
      (interactive)
      (switch-to-buffer (other-buffer (current-buffer) 1)))

;; shell scripts
(setq-default sh-basic-offset 2)
(setq-default sh-indentation 2)

;; Theme setup - need both add-to-list's
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(add-to-list 'load-path "~/.emacs.d/themes")
(load-theme 'tomorrow-night-bright t)

;; clipboard trick!
(setq x-select-enable-clipboard t)

;; window size
(setq initial-frame-alist '((top . 0) (left . 0) (width . 100) (height . 44)))

;; paredit setup
(autoload 'enable-paredit-mode "paredit"
  "Turn on pseudo-structural editing of Lisp code."
  t)
(add-hook 'emacs-lisp-mode-hook       'enable-paredit-mode)
(add-hook 'lisp-mode-hook             'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
(add-hook 'scheme-mode-hook           'enable-paredit-mode)

;; expand region
(global-set-key (kbd "C-=") 'er/expand-region)

;;; Load paxedit functionality
;;; need to have paxedit.el and paredit.el in the directory specified below
(add-to-list 'load-path "~/.emacs.d/lisp/")
(require 'paxedit)

(add-hook 'emacs-lisp-mode-hook 'paxedit-mode)
(add-hook 'clojure-mode-hook 'paxedit-mode)

(eval-after-load "paxedit"
  '(progn (define-key paxedit-mode-map (kbd "M-<right>") 'paxedit-transpose-forward)
          (define-key paxedit-mode-map (kbd "M-<left>") 'paxedit-transpose-backward)
          (define-key paxedit-mode-map (kbd "M-<up>") 'paxedit-backward-up)
          (define-key paxedit-mode-map (kbd "M-<down>") 'paxedit-backward-end)
          (define-key paxedit-mode-map (kbd "M-b") 'paxedit-previous-symbol)
          (define-key paxedit-mode-map (kbd "M-f") 'paxedit-next-symbol)
          (define-key paxedit-mode-map (kbd "C-%") 'paxedit-copy)
          (define-key paxedit-mode-map (kbd "C-&") 'paxedit-kill)
          (define-key paxedit-mode-map (kbd "C-*") 'paxedit-delete)
          (define-key paxedit-mode-map (kbd "C-^") 'paxedit-sexp-raise)
          (define-key paxedit-mode-map (kbd "M-u") 'paxedit-symbol-change-case)
          (define-key paxedit-mode-map (kbd "C-@") 'paxedit-symbol-copy)
          (define-key paxedit-mode-map (kbd "C-#") 'paxedit-symbol-kill)))
