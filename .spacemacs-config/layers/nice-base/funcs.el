(defun isolate-kill-ring()
  "Isolate Emacs kill ring from OS X system pasteboard.
This function is only necessary in window system."
  (interactive)
  (setq interprogram-cut-function nil)
  (setq interprogram-paste-function nil))

(defun pasteboard-copy()
  "Copy region to OS X system pasteboard."
  (interactive)
  (shell-command-on-region
   (region-beginning) (region-end) "pbcopy"))

(defun pasteboard-paste()
  "Paste from OS X system pasteboard via `pbpaste' to point."
  (interactive)
  (shell-command-on-region
   (point) (if mark-active (mark) (point)) "pbpaste" nil t))

(defun pasteboard-cut()
  "Cut region and put on OS X system pasteboard."
  (interactive)
  (pasteboard-copy)
  (delete-region (region-beginning) (region-end)))


(defun duplicate-line-or-region (&optional n)
  "Duplicate current line, or region if active.
With argument N, make N copies.
With negative N, comment out original line and use the absolute value."
  (interactive "*p")
  (let ((use-region (use-region-p)))
    (save-excursion
      (let ((text (if use-region        ;Get region if active, otherwise line
                      (buffer-substring (region-beginning) (region-end))
                    (prog1 (thing-at-point 'line)
                      (end-of-line)
                      (if (< 0 (forward-line 1)) ;Go to beginning of next line, or make a new one
                          (newline))))))
        (dotimes (i (abs (or n 1)))     ;Insert N times, or once if not specified
          (insert text))))
    (if use-region nil                  ;Only if we're working with a line (not a region)
      (let ((pos (- (point) (line-beginning-position)))) ;Save column
        (if (> 0 n)                             ;Comment out original with negative arg
            (comment-region (line-beginning-position) (line-end-position)))
        (forward-line 1)
        (forward-char pos)))))

(defun backward-kill-line (arg)
  "Kill ARG lines backward."
  (interactive "p")
  (kill-line (- 1 arg)))

(autoload 'c-hungry-delete-backwards "cc-cmds" t nil)
(defun smart-delete (&optional n)
  "Depending on the char before the point, delete something--
  whitespace: all preceding whitespace including tabs and newlines
  close paren/square/curly/quote/singlequote: delete the preceding s-exp
  open paren/square/curly: delete the containing s-exp
  everything else: delete the preceding word

  Error handling is minimal currently."
  (interactive "*p")
  (cond
   ;; end of sexp - delete preceding sexp
   ((member (char-before) (string-to-list ")]}'\"")) (sp-backward-kill-sexp))
   ;; beginning of sexp - delete current sexp
   ((member (char-before) (string-to-list "([{")) (progn
                                                    (backward-char)
                                                    (sp-kill-sexp)))
   ;; whitespace - delete all preceding whitespace, including tabs and newlines
   ((member (char-before) (string-to-list " \t\n")) (c-hungry-delete-backwards))
   ;; else do a normal delete word.
   (t (backward-kill-word n))))
;; At some point it'd be nice to make C-u work with all of the above


(defun save-all-buffers ()
  (interactive)
  (save-some-buffers "!"))

