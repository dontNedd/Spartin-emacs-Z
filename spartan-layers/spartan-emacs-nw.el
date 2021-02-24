;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; for terminal Emacs only (emacs -nw)

(defun spartan-emacs-nw-hook ()
  (xterm-mouse-mode 1)

  (require 'clipetty)
  (global-clipetty-mode +1))

(or window-system
    (progn
      (add-to-list 'spartan-package-list 'clipetty)
      (add-hook 'after-init-hook 'spartan-emacs-nw-hook)))

(provide 'spartan-emacs-nw)
