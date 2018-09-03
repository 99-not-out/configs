(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(add-to-list 'exec-path "/usr/local/bin/")
(set-default-font "Consolas 13")

(require 'magit)
(require 'exec-path-from-shell)

;; Make env vars the same in GUI as per shell
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

;; Add a space after line numbers in linum mode
(setq linum-format "%d ")

;; Magit open in current window
(setq magit-display-buffer-function
      (lambda (buffer)
        (display-buffer buffer '(display-buffer-same-window))))

;; custom-set-variables was added by Custom.
;; If you edit it by hand, you could mess it up, so be careful.
;; Your init file should contain only one such instance.
;; If there is more than one, they won't work right.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (magit))))

;; custom-set-faces was added by Custom.
;; If you edit it by hand, you could mess it up, so be careful.
;; Your init file should contain only one such instance.
;; If there is more than one, they won't work right.
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-function-name-face ((t (:foreground "Black"))))
 '(font-lock-keyword-face ((t (:foreground "blue1"))))
 '(highlight-symbol-face ((t (:background "color-253"))))
 '(hl-sexp-face ((t (:background "color-254"))))
 '(linum ((t (:inherit (shadow default) :foreground "color-250")))))

(put 'scroll-left 'disabled nil)
