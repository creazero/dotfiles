(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; This is only needed once, near the top of the file
(require 'use-package)

(use-package company
  :init (require 'company)
  :diminish company-mode
  :config
  (setq company-idle-delay            0.1
	company-minimum-prefix-length 1
	company-echo-delay            0
	company-show-numbers          t
	company-dabbrev-downcase      nil
	company-dabbrev-ignore-case   nil
	)
  (add-hook 'prog-mode-hook 'company-mode)
  )

;; Font setting
(add-to-list 'default-frame-alist '(font . "SF Mono-18"))

;; Hooks
(add-hook 'prog-mode-hook 'linum-mode)
(add-hook 'rust-mode-hook 'racer-mode)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("53a9ec5700cf2bb2f7059a584c12a5fdc89f7811530294f9eaf92db526a9fb5f" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "2caab17a07a40c1427693d630adb45f5d6ec968a1771dcd9ea94a6de5d9f0838" default)))
 '(package-selected-packages
   (quote
    (auctex haskell-mode git-gutter typescript-mode js2-mode vue-mode web-mode python-mode ujelly-theme doom-themes solarized-theme darktooth-theme racer rust-mode use-package company))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Settings
(setq racer-rust-src-path "/home/creazero/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src/")
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq auto-save-file-list nil)
(setq linum-format "%s ")
(setq word-wrap t)
(scroll-bar-mode -1)
(tool-bar-mode   -1)
(menu-bar-mode   -1)
(global-hl-line-mode t)

;; Mode line
(column-number-mode t)

(load-theme 'ujelly)

;; Functions
(defun kill-other-buffers ()
  "Kill other buffers"
  (interactive)
  (mapc 'kill-buffer (delq (current-buffer) (buffer-list))))

(global-set-key (kbd "C-x C-k") 'kill-other-buffers)

(eval-after-load 'latex
  '(define-key LaTeX-mode-map (kbd "C-j")
     (lambda ()
       (interactive)
       (message "hello"))))
