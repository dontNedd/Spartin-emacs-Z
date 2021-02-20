;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; ███████╗██████╗;;█████╗;██████╗;████████╗;█████╗;
;; ██╔════╝██╔══██╗██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗
;; ███████╗██████╔╝███████║██████╔╝;;;██║;;;███████║
;; ╚════██║██╔═══╝;██╔══██║██╔══██╗;;;██║;;;██╔══██║
;; ███████║██║;;;;;██║;;██║██║;;██║;;;██║;;;██║;;██║
;; ╚══════╝╚═╝;;;;;╚═╝;;╚═╝╚═╝;;╚═╝;;;╚═╝;;;╚═╝;;╚═╝
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; configuration

(setq spartan-package-list '())

(setq spartan-layers '(spartan-startup
                       spartan-performance
                       spartan-settings
                       spartan-ido
                       spartan-theme
                       spartan-builtins
                       spartan-collect-defun
                       spartan-vetted
                       spartan-macos
                       spartan-elpa-melpa
                       spartan-binds-global
                       spartan-magit
                       ;; spartan-projectile
                       spartan-eglot
                       ;; spartan-evil
                       spartan-lisp
                       spartan-bash
                       spartan-python))

;; spartan-layers

(add-to-list 'load-path (concat user-emacs-directory "spartan-layers"))

(dolist (layer spartan-layers)
  (require layer))

;; install third party packages

(with-eval-after-load 'spartan-elpa-melpa
  (spartan-package-bootstrap))

;; spartan.d/

(setq spartan-lisp-d (concat user-emacs-directory "spartan.d"))

(defun spartan-user-local-hook ()
  (when (file-directory-p spartan-lisp-d)
  (dolist (file (directory-files spartan-lisp-d nil "^.*\.el$"))
    (load-file (concat spartan-lisp-d "/" file)))))

(add-hook 'window-setup-hook 'spartan-user-local-hook)

;;; init.el ends here
