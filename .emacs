;;; package - something

;;; Commentary:
(require 'package)

;;; Code:
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(use-package evil
  :init
  (progn
    (setq evil-default-cursor t)

    (use-package evil-leader
      :init (global-evil-leader-mode)
      :config
      (progn
	(setq evil-leader/leader "<SPC>")
	(setq evil-leader/in-all-states t)
	(evil-leader/set-key
	  "e" 'helm-find-files
	  ;; Buffers
	  "b [" 'previous-buffer
	  "b ]" 'next-buffer
	  "b k" 'neotree-toggle
	  "b d" 'kill-buffer
	  "b b" 'switch-to-buffer

	  ;; Windows
	  "w l" 'evil-window-right
	  "w h" 'evil-window-left
	  "w k" 'evil-window-top
	  "w j" 'evil-window-bottom

	  "w 1" 'delete-other-windows
	  "w 2" 'split-window-below
	  "w 3" 'split-window-right

	  "n g" 'neotree-refresh
	  "n r" 'neotree-change-root
	  "n RET" 'neotree-enter
	  "n c" 'neotree-create-node

	  ":" 'helm-M-x
	  )
	(evil-leader/set-key-for-mode 'c++-mode
	  "r n" 'rtags-rename-symbol
	  "r f" 'rtags-find-symbol-at-point)
	))
    (evil-mode 1))
  :config
  (progn
    (use-package key-chord
      :init (key-chord-mode t)
      :config
      (progn
	(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)))
    (setq evil-cross-lines t)))

(use-package doom-themes
  :config
  (progn
    (setq doom-themes-enable-bold t
	  doom-themes-enable-italic t)
    (load-theme 'doom-tomorrow-night t)

    (doom-themes-neotree-config)
    ))

(use-package company
  :config
  (progn
    (add-hook 'after-init-hook 'global-company-mode)
    (global-set-key (kbd "M-/") 'company-complete-command-or-cycle)
    (setq company-idle-delay 0)))

(use-package irony
  :config
  (progn
    (unless (irony--find-server-executable) (call-interactively #'irony-install-server))
    (add-hook 'c++-mode-hook 'irony-mode)
    (add-hook 'c-mode-hook 'irony-mode)

    (setq irony-cdb-compilation-databases '(irony-cdb-libclang
					    irony-cdb-clang-complete))
    (add-hook 'irony-mode 'irony-cdb-autosetup-compile-options)

    (use-package company-irony
      :config
      (progn
	(eval-after-load 'company '(add-to-list 'company-backends 'company-irony))))
    (use-package flycheck-irony
      :config
      (progn
	(eval-after-load 'flycheck '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))))))

(use-package rtags
  :config
  (progn
    (unless (rtags-executable-find "rc") (error "Binary rc is not installed!"))
    (unless (rtags-executable-find "rdm") (error "Binary rdm is not installed"))

    (define-key c-mode-base-map (kbd "M-.") 'rtags-find-symbol-at-point)
    (define-key c-mode-base-map (kbd "M-,") 'rtags-find-references-at-point)
    (define-key c-mode-base-map (kbd "M-?") 'rtags-display-summary)
    (rtags-enable-standard-keybindings)

    (setq rtags-use-helm t)

    (add-hook 'kill-emacs-hook 'rtags-quit-rdm)
    ))

(use-package projectile
  :config
  (progn
    (projectile-global-mode)))

(add-to-list 'default-frame-alist '(font . "Roboto Mono for Powerline-16"))

(add-hook 'prog-mode-hook 'linum-mode)
(add-hook 'c++-mode-hook 'flycheck-mode)
(add-hook 'c-mode-hook 'flycheck-mode)

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(setq word-wrap t
      make-backup-files nil
      auto-save-default nil
      c-basic-offset 8
      c-default-style "linux"
      column-number-mode t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("2af26301bded15f5f9111d3a161b6bfb3f4b93ec34ffa95e42815396da9cb560" default)))
 '(package-selected-packages
   (quote
    (ninja-mode rc-mode helm-projectile projectile helm-rtags company-rtags flycheck-rtags rtags helm-mode-manager helpful git-gutter flycheck-irony company-irony irony flycheck company magit auctex haskell-mode doom-themes use-package neotree evil-leader key-chord evil))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
