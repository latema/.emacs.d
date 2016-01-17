(global-set-key [f6] 'highlight-regexp)
(global-set-key [M-f6] 'unhighlight-regexp)

(global-set-key [f8] 'cider-connect)
(global-set-key [M-f8] 'cider-quit)

(global-set-key [f11] (lambda () (interactive) (find-file "~/.lein/profiles.clj")))
(global-set-key [f12] (lambda () (interactive) (find-file "~/.emacs.d/init.el")))

(require 'projectile)

(define-key projectile-mode-map [?\s-d] 'projectile-find-dir)
(define-key projectile-mode-map [?\s-p] 'projectile-switch-project)
(define-key projectile-mode-map [?\s-f] 'projectile-find-file)
(define-key projectile-mode-map [?\s-g] 'projectile-grep)

(defun find-project-file (file)
  (find-file (expand-file-name file (projectile-project-root))))

(global-set-key [f9]
                (lambda () (interactive)
                  (find-project-file "dev/user.clj")))

(global-set-key [f10]
                (lambda () (interactive)
                  (find-project-file "project.clj")))

(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

;; hide/show
(global-set-key (kbd "C-.") 'hs-toggle-hiding)
(global-set-key (kbd "C-,") 'hs-hide-all)
(global-set-key (kbd "C-x C-,") 'hs-show-all)

;; Swap current buffer with buffer in direction of arrow
(global-set-key (kbd "<M-s-right>") 'buf-move-right)
(global-set-key (kbd "<M-s-left>") 'buf-move-left)
(global-set-key (kbd "<M-s-up>") 'buf-move-up)
(global-set-key (kbd "<M-s-down>") 'buf-move-down)

;; Move active cursor to window
(global-set-key [s-left] 'windmove-left)
(global-set-key [s-right] 'windmove-right)
(global-set-key [s-up] 'windmove-up)
(global-set-key [s-down] 'windmove-down)

(defun cider-repl-reset (force)
  (interactive "P")
  (save-some-buffers)
  (when force
    (find-project-file "dev/user.clj")
    (cider-load-buffer))
  (with-current-buffer (cider-current-repl-buffer)
    (goto-char (point-max))
    (insert "(user/reset)")
    (cider-repl-return)))

(global-set-key (kbd "C-c r") 'cider-repl-reset)

(defun cider-repl-dev-reset ()
  (interactive)
  (save-some-buffers)
  (with-current-buffer (cider-current-repl-buffer)
    (goto-char (point-max))
    (insert "(user/dev-reset)")
    (cider-repl-return)))

(global-set-key (kbd "C-c R") 'cider-repl-dev-reset)

(defun cider-class-path ()
  (interactive)
  (with-current-buffer (cider-current-repl-buffer)
    (goto-char (point-max))
    (insert "(pprint (sort (.split (System/getProperty \\\"java.class.path\\\") \\\":\\\")))")
    (cider-repl-return)))

(global-set-key (kbd "C-c P") 'cider-class-path)

(eval-after-load "paxedit"
  '(cu-mode-keyboard paxedit-mode-map
                     "C-c C-c" 'paxedit-cleanup
                     ";" 'paxedit-insert-semicolon
                     "C-;" (lambda () (interactive)
                             (insert ?\;))
                     "M-<right>" 'paxedit-transpose-forward
                     "M-<left>" 'paxedit-transpose-backward
                     "M-<up>" 'paxedit-backward-up
                     "M-<down>" 'paxedit-backward-end
                     "M-b" 'paxedit-previous-symbol
                     "M-f" 'paxedit-next-symbol
                     "C-%" 'paxedit-copy
                     "C-&" 'paxedit-kill
                     "C-*" 'paxedit-delete
                     "C-^" 'paxedit-sexp-raise
                     "M-u" 'paxedit-symbol-change-case
                     "C-@" 'paxedit-symbol-copy
                     "C-#" 'paxedit-symbol-kill
                     "C-=" 'paxedit-wrap-parent-sexp
                     "C-!" 'paxedit-flatten
                     "C-~" 'paxedit-dissolve
                     "C-<return>" 'paxedit-context-new-statement))

(defun win-resize-top-or-bot ()
  "Figure out if the current window is on top, bottom or in the
middle"
  (let* ((win-edges (window-edges))
         (this-window-y-min (nth 1 win-edges))
         (this-window-y-max (nth 3 win-edges))
         (fr-height (frame-height)))
    (cond
     ((eq 0 this-window-y-min) "top")
     ((eq (- fr-height 1) this-window-y-max) "bot")
     (t "mid"))))

(defun win-resize-left-or-right ()
  "Figure out if the current window is to the left, right or in the
middle"
  (let* ((win-edges (window-edges))
         (this-window-x-min (nth 0 win-edges))
         (this-window-x-max (nth 2 win-edges))
         (fr-width (frame-width)))
    (cond
     ((eq 0 this-window-x-min) "left")
     ((eq (+ fr-width 4) this-window-x-max) "right")
     (t "mid"))))

(defun win-resize-enlarge-vert ()
  (interactive)
  (cond
   ((equal "top" (win-resize-top-or-bot)) (enlarge-window -5))
   ((equal "bot" (win-resize-top-or-bot)) (enlarge-window 5))
   ((equal "mid" (win-resize-top-or-bot)) (enlarge-window -5))
   (t (message "nil"))))

(defun win-resize-minimize-vert ()
  (interactive)
  (cond
   ((equal "top" (win-resize-top-or-bot)) (enlarge-window 5))
   ((equal "bot" (win-resize-top-or-bot)) (enlarge-window -5))
   ((equal "mid" (win-resize-top-or-bot)) (enlarge-window 5))
   (t (message "nil"))))

(defun win-resize-enlarge-horiz ()
  (interactive)
  (cond
   ((equal "left" (win-resize-left-or-right)) (enlarge-window-horizontally -30))
   ((equal "right" (win-resize-left-or-right)) (enlarge-window-horizontally 30))
   ((equal "mid" (win-resize-left-or-right)) (enlarge-window-horizontally 30))))

(defun win-resize-minimize-horiz ()
  (interactive)
  (cond
   ((equal "left" (win-resize-left-or-right)) (enlarge-window-horizontally 30))
   ((equal "right" (win-resize-left-or-right)) (enlarge-window-horizontally -30))
   ((equal "mid" (win-resize-left-or-right)) (enlarge-window-horizontally -30))))

(global-set-key [s-S-left] 'win-resize-enlarge-horiz)
(global-set-key [s-S-right] 'win-resize-minimize-horiz)
(global-set-key [s-S-up] 'win-resize-enlarge-vert)
(global-set-key [s-S-down] 'win-resize-minimize-vert)
