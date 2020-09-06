;; .emacs.d/init.el
;;
;; Emacs config by Miika Nissi

;; PACKAGES
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; use-package, makes installing other packages simple
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; shows options for emacs commands
(use-package which-key
  :ensure t
  :config
  (which-key-mode))

;; loads theme
(use-package base16-theme
  :ensure t
  :config
  (load-theme 'base16-hopscotch t))

;; doom modeline
(use-package doom-modeline
  :ensure t
  :hook
  (after-init . doom-modeline-mode))

;; icons for doom modeline
(use-package all-the-icons
  :ensure t)

;; helps navigating files in projects
(use-package projectile
  :ensure t
  :config
  (define-key projectile-mode-map (kbd "C-x p") 'projectile-command-map)
  (projectile-mode +1))

;; dashboard when emacs starts
(use-package dashboard
  :ensure t
  :init
  (progn
    (setq dashboard-banner-logo-title "Welcome to Emacs, Miika!")
    (setq dashboard-set-heading-icons t)
    (setq dashboard-items '((recents . 5)
			    (projects . 5)))
    )
  :config
  (dashboard-setup-startup-hook))

;; treemacs project file manager
(use-package treemacs
  :ensure t
  :bind
  (:map global-map
	([f8] . treemacs)
	("C-<f8>" . treemacs-select-window))
  :config
  (setq treemacs-is-never-other-window t))

;; treemacs projectiles
(use-package treemacs-projectile
  :after treemacs projectile
  :ensure t)

;; company-mode aka autocomplete
(use-package company
  :ensure t
  :hook (after-init . global-company-mode)
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 3))

;;  ("SPC" . company-abort))

;; irony to support c/c++ autocompletion
(use-package company-irony
  :ensure t
  :config
  (require 'company)
  (add-to-list 'company-backends 'company-irony))

;; irony to support c/c++ autocompletion
(use-package irony
  :ensure t
  :config
  (add-hook 'c++-mode-hook 'irony-mode)
  (add-hook 'c-mode-hook 'irony-mode)
  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options))

;; CONFIGS
;; no startup message
(setq inhibit-startup-message t)

;; no toolbar
(tool-bar-mode -1)

;; no menubar
(menu-bar-mode -1)

;; no scrollbar
(scroll-bar-mode -1)

;; highlight current line
(global-hl-line-mode +1)

;; delete selection mode
(delete-selection-mode +1)

;; default directory
(setq-local default-directory "~/.emacs.d/saves")

;; backup and autosave directory
(setq temporary-file-directory "~/.emacs.d/saves/")

;; change backup directory
(setq backup-directory-alist 
      `((".*" . ,temporary-file-directory)))

;; change autosave directory
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; show linenumbers in programming mode
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; show matching paranthesis
(show-paren-mode +1)

;; helps file and buffer browsing
(setq ido-everywhere t)
(setq ido-enable-flex-matching t)
(ido-mode t)

;; Sets python interpreter to python3
(setq python-shell-interpreter "python3")

;; Should help with emacs starting in tiled mode in bspwm
(setq frame-resize-pixelwise t)

;; transparency
(set-frame-parameter (selected-frame) 'alpha '(90 . 90))
(add-to-list 'default-frame-alist '(alpha 90 . 90))

;; change company keybinds
(with-eval-after-load 'company
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous))

;; add c/c++ to company
(with-eval-after-load 'company
  (add-hook 'c++-mode-hook 'company-mode)
  (add-hook 'c-mode-hook 'company-mode))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(company-irony company treemacs-projectile treemacs dashboard projectile doom-modeline base16-theme which-key use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
