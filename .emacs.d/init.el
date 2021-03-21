;; init.el - My Emacs configuration
;;
;; Copyright (C) 2021- Miika Nissi
;;
;; Author: Miika Nissi <miika@miikanissi.com>
;;
;; Following lines load an Org file which contains my configuration.
;;
;; Code:
(org-babel-load-file (expand-file-name "~/.emacs.d/config.org"))
;; Set the working directory to home regardless of where Emacs was started from
(cd "~/")
;; Collect garbage when all else is done
(garbage-collect)
