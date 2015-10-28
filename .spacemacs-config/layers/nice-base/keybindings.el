;; Use Command-` to switch between Emacs windows (not frames)
(bind-key "H-s-m" 'other-window)

;; Use Command-Shift-` to switch Emacs frames in reverse
(bind-key "H-s-n" (lambda() () (interactive) (other-window -1)))

;; remove all the hyper key defaults that I don't use
(dolist (key '("H-a" "H-b" "H-c" "H-d" "H-e" "H-f" "H-g"
               "H-h" "H-i" "H-j" "H-k" "H-l" "H-m" "H-n"
               "H-o" "H-p" "H-q" "H-r" "H-s" "H-t" "H-u"
               "H-v" "H-w" "H-x" "H-y" "H-z"))
  (global-unset-key (kbd key)))

(setq mac-function-modifier 'hyper)

;; Clear the middle mouse button binding since I use middle mouse pressed +
;; scroll to zoom in and out.
(global-unset-key [mouse-2])

(bind-key "C-S-k" 'kill-whole-line)
(bind-key "H-s-<backspace>" 'kill-line)
(bind-key "s-<backspace>" 'backward-kill-line)
(bind-key "C-S-d" 'duplicate-line-or-region)

(bind-key "H-m" 'spacemacs/next-useful-buffer)
(bind-key "H-n" 'spacemacs/previous-useful-buffer)
  
(bind-key "M-<backspace>" 'smart-delete)
(bind-key "H-<SPC>" 'hippie-expand)

(bind-key "M-s-s" 'save-all-buffers)

