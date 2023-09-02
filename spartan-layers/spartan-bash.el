;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; `shell' is the preferred spartan-emacs shell because eshell and ansi/multi/term are all too buggy while vterm is bloat
;; `shell' is a bash process attached to a buffer, so it has all of Emacs bindings, etc. That's perfect.

;; If you really need ncurses, you're probably doing it wrong.

(add-to-list 'spartan-package-list 'better-shell) ; https://github.com/killdash9/better-shell
(add-to-list 'spartan-package-list 'shx)          ; https://github.com/riscy/shx-for-emacs
(when (executable-find "shellcheck") (add-to-list 'spartan-package-list 'flymake-shellcheck)) ; Add shellcheck support to flymake (linter)

(defun spartan-shell-hook ()
  ;; SUPER helpful `shell' extensions
  (require 'shx)
  (shx-global-mode 1)

  ;; Greatly improve M-x `shell' by using `sh' aliased to `better-shell-for-current-dir'
  (require 'better-shell)

  ;; bash everywhere because this is __GNU__ Emacs after all...
  (setq tramp-default-remote-shell "/bin/bash"
        explicit-shell-file-name "bash")

  ;; sh/bash linter
  (or
   ;; prefer shellcheck
   (when (executable-find "shellcheck")
     (require 'flymake-shellcheck)
     (setq flymake-shellcheck-use-file nil)
     (add-hook 'sh-mode-hook 'flymake-shellcheck-load)))

  ;; auto chmod +x scripts
  (add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

  ;; clickable jump to line of code from error output in shell mode
  (add-hook 'shell-mode-hook 'compilation-shell-minor-mode)

  ;; much improved perf in shell-mode buffers
  ;; https://stackoverflow.com/questions/26985772/fast-emacs-shell-mode
  (setq comint-move-point-for-output nil
        comint-scroll-show-maximum-output nil))

(add-hook 'after-init-hook 'spartan-shell-hook)

(provide 'spartan-bash)
