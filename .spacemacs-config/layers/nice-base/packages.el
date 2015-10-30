;;; packages.el --- nice-base Layer packages File for Spacemacs
;;
;; Copyright (c) 2012-2014 Sylvain Benner
;; Copyright (c) 2014-2015 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;; List of all packages to install and/or initialize. Built-in packages
;; which require an initialization must be listed explicitly in the list.
(setq nice-base-packages
    '(phi-search
      phi-search-mc
      ace-jump-mode
      expand-region
      rainbow-identifiers
      company
      multiple-cursors
      ace-jump-zap
      smartparens))

;; List of packages to exclude.
(setq nice-base-excluded-packages '())

(defun nice-base/init-phi-search ()
   (use-package phi-search
     :bind (("C-s" . phi-search)
            ("C-S-s" . phi-search-backward))
     :config
     (unbind-key "C-r") ;; TODO: move somewhere more obvious since this globally unbinds
     (bind-key "C-r" 'phi-replace-query)
     (use-package phi-search-mc)))

(defun nice-base/init-ace-jump-mode ()
  (use-package ace-jump-mode
    :bind (("H-'" . ace-jump-mode))
    :config
    (setq-default ace-jump-mode-case-fold t)))

(defun nice-base/init-ace-jump-zap ()
  (use-package ace-jump-zap
    :bind ("s-k" . ace-jump-zap-to-char)))

(defun nice-base/init-phi-search-mc ()
  (use-package phi-search-mc
    :config
    (phi-search-mc/setup-keys)
    (bind-key "C-d" 'phi-search-mc/mark-here phi-search-default-map)
    (bind-key "C-S-d" 'phi-search-mc/mark-all phi-search-default-map)))

(defun nice-base/post-init-expand-region ()
  (bind-key "H-b" 'er/expand-region))

(defun nice-base/pre-init-company ()
  (spacemacs|use-package-add-hook company
    :post-config
    (bind-keys
     :map company-active-map
     ("C-n" . company-select-next)
     ("C-p" . company-select-previous))))

(defun nice-base/post-init-multiple-cursors ()
  (bind-key "s-l" 'mc/edit-lines))

(defun nice-base/post-init-smartparens ()
  (bind-keys
     :map smartparens-mode-map
     ("H-y" . sp-beginning-of-sexp)
     ("H-p" . sp-end-of-sexp)

     ("H-s-o" . sp-down-sexp)
     ("H-s-p" . sp-up-sexp)
     ("H-s-u" . sp-backward-down-sexp)
     ("H-s-y" . sp-backward-up-sexp)

     ("H-s-l" . sp-forward-sexp)
     ("H-s-j" . sp-backward-sexp)

     ("H-s-;" . sp-next-sexp)
     ("H-s-h" . sp-previous-sexp)))

;; Here rainbow-identifiers-mode is used to just add the variable
;; face to all instances of variable identifiers in js2-mode
(defun nice-base/init-rainbow-identifiers ()
  (use-package rainbow-identifiers
    :config
    (setq-default rainbow-identifiers-face-count 1)
    (add-hook 'js2-mode-hook 'rainbow-identifiers-mode)))

;; For each package, define a function nice-base/init-<package-name>
;;
;; (defun nice-base/init-my-package ()
;;   "Initialize my package"
;;   )
;;
;; Often the body of an initialize function uses `use-package'
;; For more info on `use-package', see readme:
;; https://github.com/jwiegley/use-package
