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
 '(custom-safe-themes
   '("78c4238956c3000f977300c8a079a3a8a8d4d9fee2e68bad91123b58a4aa8588" "83e0376b5df8d6a3fbdfffb9fb0e8cf41a11799d9471293a810deb7586c131e6" "7661b762556018a44a29477b84757994d8386d6edee909409fabe0631952dad9" "6b5c518d1c250a8ce17463b7e435e9e20faa84f3f7defba8b579d4f5925f60c1" "c433c87bd4b64b8ba9890e8ed64597ea0f8eb0396f4c9a9e01bd20a04d15d358" "830877f4aab227556548dc0a28bf395d0abe0e3a0ab95455731c9ea5ab5fe4e1" default))
 '(package-selected-packages
   '(ox-rss password-store-otp password-store solarized-theme telega dmenu yasnippet-snippets which-key web-mode use-package symon switch-window swiper sudo-edit spaceline smex simple-mpc rg rainbow-mode rainbow-delimiters projectile prettier-js popup-kill-ring ox-twbs org-bullets mingus magit linum-relative ido-vertical-mode ido-completing-read+ htmlize gruvbox-theme flycheck-clang-analyzer fancy-battery eterm-256color emms doom-modeline diminish dashboard company-shell company-jedi company-irony company-c-headers beacon avy auto-package-update async))
 '(winner-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
