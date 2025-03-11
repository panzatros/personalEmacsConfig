;; -*- lexical-binding: t; -*-

;; Basic settings
(setq inhibit-startup-screen t)
(global-display-line-numbers-mode 1)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(set-frame-font "Consolas-12" nil t)
(column-number-mode 1)
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

;; Package setup
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;; Java-specific
(use-package eglot
  :hook (java-mode . eglot-ensure)
  :config
  (add-to-list 'eglot-server-programs
               '(java-mode . ("C:\\tools\\jdtls\\bin\\jdtls.bat" "-data" "C:\\Users\\ragde\\jdtls-workspace" "--add-modules=ALL-SYSTEM" "--add-opens" "java.base/java.util=ALL-UNNAMED"))))
(use-package eglot
  :hook (java-mode . eglot-ensure)
  :config
  (add-to-list 'eglot-server-programs
               '(java-mode . ("C:/tools/jdtls/bin/jdtls.bat" "-data" "C:/Users/ragde/jdtls-workspace"
                              "--add-modules=ALL-SYSTEM" "--add-opens" "java.base/java.util=ALL-UNNAMED")))
  ;; Add debug output
  (setq eglot-report-progress t)
  (setq eglot-sync-connect 5))  ;; Wait longer for server to connect

(use-package company
  :hook (prog-mode . company-mode)
  :config
  (setq company-idle-delay 0.2)
  (setq company-minimum-prefix-length 1))

(use-package projectile
  :bind-keymap ("C-c p" . projectile-command-map)
  :init
  (projectile-mode +1))

(add-hook 'java-mode-hook
          (lambda ()
            (setq c-basic-offset 4)
            (setq tab-width 4)
            (electric-pair-mode 1)))

;; Keybindings
(global-set-key (kbd "<f5>") (lambda () (interactive) (compile "javac *.java")))
(global-set-key (kbd "<f6>") (lambda () (interactive) (shell-command "java Main")))

;; Extras
(use-package magit
  :bind ("C-x g" . magit-status))

(use-package solarized-theme
  :init (load-theme 'solarized-dark t))

(ido-mode 1)
(setq ido-enable-flex-matching t)

;; Windows-specific
(setenv "JAVA_HOME" "C:\\Program Files\\Java\\jdk-17")
(setenv "PATH" (concat (getenv "JAVA_HOME") "\\bin;" (getenv "PATH")))


(require 'neotree)
(global-set-key [f8] 'neotree-toggle)
(setq neo-window-width 40)


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


(tool-bar-mode -1)    ;; Hide the toolbar
(menu-bar-mode -1)    ;; Hide the menu bar

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
