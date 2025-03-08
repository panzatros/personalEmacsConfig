(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(manoj-dark))
 '(package-selected-packages
   '(all-the-icons centaur-tabs helm-swoop flycheck-rust req-package elpy rust-mode haskell-mode helm-lsp lsp-java which-key lsp-ui company hydra lsp-mode yasnippet flycheck projectile interaction-log sweet-theme use-package rustic cargo)))
 
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

;;helm
(use-package helm
  :ensure t
  :config
  (helm-mode 1))

;;helm lsp
(use-package helm-lsp
  :ensure t
  :after (helm lsp-mode)
  :commands helm-lsp-workspace-symbol)

;;helm configuration for LSP
(use-package lsp-mode
  :ensure t
  :hook (rust-mode . lsp)  ; Start LSP automatically in rustic/rust-mode
  :commands lsp
  :config
  ;; Use Helm for LSP commands
  (define-key lsp-mode-map (kbd "C-c h s") #'helm-lsp-workspace-symbol)  ; Workspace symbols
  (define-key lsp-mode-map (kbd "C-c h d") #'helm-lsp-global-definitions) ; All definitions
  (define-key lsp-mode-map (kbd "C-c h r") #'helm-lsp-references))       ; References


>(global-set-key (kbd "C-c i") #'helm-imenu)
(global-set-key (kbd "C-x C-f") #'helm-find-files)

(use-package helm-swoop
  :ensure t
  :bind (("C-c s" . helm-swoop)))

;;use of centaur tabs
(use-package centaur-tabs
  :demand
  :config
  (centaur-tabs-mode t)
  :bind
  ("C-<prior>" . centaur-tabs-backward)
  ("C-<next>" . centaur-tabs-forward))

;;install all the icons font 
(use-package all-the-icons
  :ensure t)

(setq centaur-tabs-style "wave")
(setq centaur-tabs-height 32)
(setq centaur-tabs-set-icons t)
(setq centaur-tabs-icon-type 'all-the-icons)  ; or 'nerd-icons
(setq centaur-tabs-set-bar 'under)
;; Note: If you're not using Spacmeacs, in order for the underline to display
;; correctly you must add the following line:
(setq x-underline-at-descent-line t)
(setq centaur-tabs-set-close-button "X")
(setq centaur-tabs-set-modified-marker t)

;;centaur tabs uses letf click to close buffers wich i dont like in teh rare ocation I use a mouse to interact with other tabs
(defun my-centaur-tabs-switch-to-buffer (event)
  "Switch to buffer on mouse click."
  (interactive "e")
  (let ((buffer (window-buffer (posn-window (event-end event)))))
    (switch-to-buffer buffer)))

(defun my-centaur-tabs-close-tab (event)
  "Close tab on mouse click."
  (interactive "e")
  (let ((buffer (window-buffer (posn-window (event-end event)))))
    (kill-buffer buffer)))

(define-key centaur-tabs-mode-map [mouse-1] 'my-centaur-tabs-switch-to-buffer)
(define-key centaur-tabs-mode-map [mouse-3] 'my-centaur-tabs-close-tab)


(tool-bar-mode -1)    ;; Hide the toolbar
(menu-bar-mode -1)    ;; Hide the menu bar
(scroll-bar-mode -1)  ;; Hide the scroll bar

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
