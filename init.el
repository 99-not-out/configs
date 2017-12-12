(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(tool-bar-mode -1)
(add-to-list 'exec-path "/usr/local/bin/")

(require 'cider)
(require 'magit)
(require 'paredit)
(require 'undo-tree)
(require 'highlight-symbol)
(require 'expand-region)
(require 'ivy)
(require 'swiper)
(require 'counsel)
(require 'company)
(require 'ivy-hydra)
(require 'projectile)
(require 'counsel-projectile)
(require 'multiple-cursors)
(require 'exec-path-from-shell)
(require 'focus)
(require 'browse-kill-ring)
(require 'wgrep)

;; Make env vars the same in GUI as per shell
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

;; Custom functions
(global-set-key (kbd "C-f") 'isearch-forward)

(defun show-file-name ()
  "Show the full path file name in the minibuffer."
  (interactive)
  (message (buffer-file-name)))
(global-set-key (kbd "<f12>") 'show-file-name)

(defun reverse-transpose-sexps (arg)
  (interactive "*p")
  (transpose-sexps (- arg))
  (backward-sexp (1+ arg))
  (forward-sexp 2))
(global-set-key (kbd "C-M-y") 'reverse-transpose-sexps)

;; Add a space after line numbers in linum mode
(setq linum-format "%d ")

;; Highlight Symbol setup - bind to F3
(global-set-key [(control f3)] 'highlight-symbol)
(global-set-key [f3] 'highlight-symbol-next)
(global-set-key [(shift f3)] 'highlight-symbol-prev)
(global-set-key [(meta f3)] 'highlight-symbol-query-replace)
(setq highlight-symbol-idle-delay 0.5)

;; Expand Region setup
(global-set-key (kbd "C-=") 'er/expand-region)

;; Undo Tree setup
(global-undo-tree-mode)

;; Hide/Show setup
(global-set-key (kbd "C-c <up>")    'hs-hide-all)
(global-set-key (kbd "C-c <down>")  'hs-show-all)
(global-set-key (kbd "C-c <right>") 'hs-hide-block)
(global-set-key (kbd "C-c <left>")  'hs-show-block)

;; Ivy & Counsel setup
(ivy-mode 1)
(counsel-projectile-on)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(global-set-key (kbd "C-s") 'swiper)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "C-c r") 'ivy-resume)
(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)

;; Clojure Mode setup
(add-hook 'clojure-mode-hook 'hs-minor-mode)
(add-hook 'clojure-mode-hook 'paredit-mode)
(add-hook 'clojure-mode-hook 'highlight-symbol-mode)
(add-hook 'clojure-mode-hook 'company-mode)

;; Projectile setup
(projectile-mode)
(global-set-key (kbd "C-.") 'counsel-projectile-ag)

;; Multiple Cursors setup
(global-set-key (kbd "C-c >") 'mc/mark-next-like-this-symbol)
(global-set-key (kbd "C-c <") 'mc/mark-previous-like-this-symbol)
(global-set-key (kbd "C-c /") 'mc/mark-all-symbols-like-this-in-defun)

;; Browse kill ring aetup
(global-set-key (kbd "C-c k") 'browse-kill-ring)


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
    (wgrep browse-kill-ring focus exec-path-from-shell multiple-cursors counsel-projectile projectile ivy-hydra company counsel swiper ivy expand-region highlight-symbol undo-tree paredit magit cider))))

;; custom-set-faces was added by Custom.
;; If you edit it by hand, you could mess it up, so be careful.
;; Your init file should contain only one such instance.
;; If there is more than one, they won't work right.
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-comment-face ((t (:foreground "color-245"))))
 '(font-lock-function-name-face ((t (:foreground "Black"))))
 '(font-lock-keyword-face ((t (:foreground "blue1"))))
 '(highlight-symbol-face ((t (:background "color-253"))))
 '(linum ((t (:inherit (shadow default) :foreground "color-250")))))

(put 'scroll-left 'disabled nil)
