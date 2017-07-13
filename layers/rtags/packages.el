;;; packages.el --- rtags layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `rtags-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `rtags/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `rtags/pre-init-PACKAGE' and/or
;;   `rtags/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst rtags-packages '(ac-rtags company-rtags flycheck-rtags helm-rtags))

;;(defun my-flycheck-rtags-setup ()
;;  (flycheck-select-checker 'rtags)
;;  (setq-local flycheck-highlighting-mode nil) ;; RTags creates more accurate overlays.
;;  (setq-local flycheck-check-syntax-automatically nil)
;;  )
;;;;;
;;;;; Adapted from comment:
;;;;; https://github.com/syl20bnr/spacemacs/issues/2327#issuecomment-153283156
;;;;; by user
;;;;; https://github.com/autosquid
;;;;;
;;(defun rtags-major-mode-keybindings (mode)
;;  (spacemacs/set-leader-keys-for-major-mode
;;    mode "R." 'rtags-find-symbol-at-point "R,"
;;    'rtags-find-references-at-point "Rv" 'rtags-find-virtuals-at-point
;;    "RV" 'rtags-print-enum-value-at-point "R/"
;;    'rtags-find-all-references-at-point "RY" 'rtags-cycle-overlays-on-screen
;;    "R>" 'rtags-find-symbol "R<" 'rtags-find-references
;;    "R[" 'rtags-location-stack-back "R]" 'rtags-location-stack-forward
;;    "RD" 'rtags-diagnostics "RG" 'rtags-guess-function-at-point
;;    "Rp" 'rtags-set-current-project "RP" 'rtags-print-dependencies
;;    "Re" 'rtags-reparse-file "RE" 'rtags-preprocess-file
;;    "RR" 'rtags-rename-symbol "RM" 'rtags-symbol-info
;;    "RS" 'rtags-display-summary "RO" 'rtags-goto-offset
;;    "R;" 'rtags-find-file "RF" 'rtags-fixit "RL"
;;    'rtags-copy-and-print-current-location "RX"
;;    'rtags-fix-fixit-at-point "RB" 'rtags-show-rtags-buffer
;;    "RI" 'rtags-imenu "RT" 'rtags-taglist "Rh"
;;    'rtags-print-class-hierarchy "Ra" 'rtags-print-source-arguments))

(defun rtags/init-rtags ()
  "Initialize rtags"
  (use-package rtags
    ))

;; (defun rtags/init-cmake-ide ()
;;   "Initialize cmake-ide"
;;   (use-package cmake-ide))
;;     ;; :config (progn
;;     ;;           (cmake-ide-setup))))

(defun rtags/init-ac-rtags ()
  (use-package ac-rtags))

(defun rtags/init-company-rtags ()
  (use-package company-rtags))

(defun rtags/init-flycheck-rtags ()
  (use-package flycheck-rtags))

(defun rtags/init-helm-rtags ()
  (use-package helm-rtags))

;; (defun rtags/post-init-company ()
;;   (add-to-list 'company-backends 'company-rtags)
;;   (setq company-rtags-begin-after-member-access
;;         t)
;;   (setq rtags-completions-enabled t)
;;   )
                                        ; packages.el ends here
