(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(manoj-dark))
 '(package-selected-packages
   '(flycheck-rust req-package elpy rust-mode haskell-mode magit helm-lsp lsp-java which-key lsp-ui company hydra lsp-mode yasnippet flycheck projectile interaction-log sweet-theme use-package rustic cargo)))
 
;; Load package management
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)

;; Ensure use-package is installed
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Always ensure packages are installed
(require 'use-package)
(setq use-package-always-ensure t)

;; Configuration for elpy
(use-package elpy
  :init
  (elpy-enable))

;; Declare variables to avoid warnings
(defvar python-shell-virtualenv-path nil)
(defvar python-shell-virtualenv-root nil)

;;define routs for cargo
(setenv "PATH" (concat (getenv "PATH") ":/home/panzatros/.cargo/bin"))
(setq exec-path (append exec-path '("/home/panzatros/.cargo/bin")))

;; Configuration for rust-mode (commented as im using rustic)
;;(use-package rust-mode
;;  :mode ("\\.rs\\'" . rust-mode)
;;  :hook (rust-mode . cargo-minor-mode))
;; Configuration for rustic (enhanced rust-mode)
;; use "rustup component add rust-analyzer" on bash to install missing packges
;; to verify rust analyzer version run rust-analyzer --version
(use-package rustic
  :ensure
  :bind (:map rustic-mode-map
         ("M-j" . lsp-ui-imenu)
         ("M-?" . lsp-find-references)
         ("C-c C-c l" . flycheck-list-errors)
         ("C-c C-c a" . lsp-execute-code-action)
         ("C-c C-c r" . lsp-rename)
         ("C-c C-c q" . lsp-workspace-restart)
         ("C-c C-c Q" . lsp-workspace-shutdown)
         ("C-c C-c s" . lsp-rust-analyzer-status))
  :config
  (setq rustic-format-on-save t)
  (add-hook 'rustic-mode-hook 'rk/rustic-mode-hook))

(defun rk/rustic-mode-hook ()
  ;; Enable LSP
  (lsp)
  ;; Enable Flycheck
  (flycheck-mode))

;; Ensure lsp-mode and lsp-ui are installed
(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook (rustic-mode . lsp-deferred)
  :config
  (setq lsp-rust-server 'rust-analyzer))

(use-package lsp-ui
  :commands lsp-ui-mode)

;; Ensure company-mode is installed for autocompletion
(use-package company
  :ensure t
  :config
  (add-hook 'after-init-hook 'global-company-mode))

;; Ensure flycheck is installed for syntax checking
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

;;flycheck rust
(use-package flycheck-rust
  :ensure t
  :after flycheck
  :config
  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))

;; Enable line display in editor
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; Enable font highlighting
(global-font-lock-mode t)

;; Git extension (currently commented out)
;; (use-package magit
;;   :ensure t)

;; seq part of magit issue (currently commented out)
;; (add-to-list 'load-path "~/.emacs.d/lisp/")
;; (require 'seq)
;; (seq-contains '(1 2 3) 2)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
