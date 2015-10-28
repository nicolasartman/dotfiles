;; Overwrite selected text when typing in it
(delete-selection-mode 1)

;; Don't make new frames when opening a new file with Emacs
(setq ns-pop-up-frames nil)

;; Disable these commands as they're of no use in the OS X GUI
(put 'ns-print-buffer 'disabled t)
(put 'suspend-frame 'disabled t)


;; Use OS X's mdfind (spotlight's commandline interface) for locate
(setq helm-locate-command "mdfind -name %s %s")

;; Separate kill-ring and OS X system clipboard
(if window-system
    (progn
      (isolate-kill-ring)
      ;; bind CMD+C to pasteboard-copy
      (global-set-key (kbd "s-c") 'pasteboard-copy)
      ;; bind CMD+V to pasteboard-paste
      (global-set-key (kbd "s-v") 'pasteboard-paste)
      ;; bind CMD+X to pasteboard-cut
      (global-set-key (kbd "s-x") 'pasteboard-cut))

  ;; you might also want to assign some keybindings for non-window
  ;; system usage (i.e., in your text terminal, where the
  ;; command->super does not work)
  )
;; handle emacs utf-8 input better - enable if issues start occuring
;; (set-terminal-coding-system 'utf-8)
;; (set-keyboard-coding-system 'utf-8)
;; (prefer-coding-system 'utf-8)
;; (setenv "LANG" "en_US.UTF-8")

;; Disable highlighting the current line
(global-hl-line-mode -1)

;; Disable rainbow delimiters globally, to be reenabled per mode
;; (rainbow-delimiters-mode nil)

;; TEMP
(setq js2-highlight-external-variables nil)
(setq js2-basic-offset 2)

;; (bind-key "<SPC>" 'ido-comp ido-file-completion-map)
