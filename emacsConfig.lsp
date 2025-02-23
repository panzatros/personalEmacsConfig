(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(manoj-dark))
 '(package-selected-packages
   '(elpy rust-mode haskell-mode magit helm-lsp lsp-java which-key lsp-ui company hydra lsp-mode yasnippet flycheck projectile interaction-log sweet-theme use-package)))

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

;; Configuration for rust-mode
(use-package rust-mode
  :mode ("\\.rs\\'" . rust-mode)
  :hook (rust-mode . cargo-minor-mode))

;;this is used to enable line display while in editor
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; FONT HIGHLIGTHING ALWAYS ON
(global-font-lock-mode t)

;;git extension
(use-package magit
  :ensure t)

;;NEDEED BY GIT FOR SECUENTIAL FUNTIONS MORE INFO https://elpa.gnu.org/packages/seq.html
(setq package-install-upgrade-built-in t)

;; FOR AUTOCOMPLETITION company-mod MORE INFOR AT https://company-mode.github.io/
(use-package company
  :ensure t
  :config
  (add-hook 'after-init-hook 'global-company-mode))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
