(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; config organized in org-mode
(org-babel-load-file (expand-file-name "~/.config/emacs/config.org"))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(telega dmenu yasnippet-snippets which-key web-mode use-package symon switch-window swiper sudo-edit spaceline smex simple-mpc rg rainbow-mode rainbow-delimiters projectile prettier-js popup-kill-ring ox-twbs org-bullets mingus magit linum-relative ido-vertical-mode ido-completing-read+ htmlize gruvbox-theme flycheck-clang-analyzer fancy-battery eterm-256color emms doom-modeline diminish dashboard company-shell company-jedi company-irony company-c-headers beacon avy auto-package-update async))
 '(winner-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
