(setq inhibit-startup-message t)
(setq inhibit-scratch-message nil)

;;PacMan stuff
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives
	     '("gnu" . "http://elpa.gnu.org/packages/"))
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(setq package-check-signature nil)

(eval-when-compile
  (require 'use-package))

;; autocompletion
(use-package company
  :ensure t
  :init
  (add-hook 'after-init-hook 'global-company-mode))

;; vim keybindings
;; download evil 
(unless (package-installed-p 'evil)
  (package-install 'evil))
;; enable evil
(require 'evil)
(evil-mode 1)
(setq mac-option-modifier 'meta)
(setq sentence-end-double-space nil)

;; which key
(use-package which-key
  :ensure t 
  :config
  (which-key-mode))


;; commenting
(unless (package-installed-p 'evil-nerd-commenter)
  (package-install 'evil-nerd-commenter))
(global-set-key (kbd "M-;") 'evilnc-comment-or-uncomment-lines)
(require 'origami)

;; appearance
(load-theme 'zenburn t)
(setq scroll-conservatively 100)
(global-linum-mode t)
(menu-bar-mode -1)
(setq linum-format "%4d \u2502 ")

;;org-mode
(require 'org)
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
;; all this stuff taken from Harry Schwarz, github.com/hrs
(setq org-directory "~/org")

(defun org-file-path (filename)
  "Return the absolute address of an org file, given its relative name."
  (concat (file-name-as-directory org-directory) filename))

(setq org-index-file (org-file-path "index.org"))
(setq org-archive-location
      (concat (org-file-path "archive.org") "::* From %s"))

(setq org-agenda-files (list org-index-file
			     (org-file-path "myl.org")
			     (org-file-path "misc.org")
			     (org-file-path "school.org")
			     (org-file-path "work.org")))
(with-eval-after-load 'org (setq org-default-notes-file (expand-file-name "misc.org" org-directory)))

(defun mark-done-and-archive ()
  "Mark the state of an org-mode item as DONE and archive it."
  (interactive)
  (org-todo 'done)
  (org-archive-subtree))

(define-key org-mode-map (kbd "C-c C-x C-s") 'mark-done-and-archive)
(setq org-log-done 'time)
(setq org-enforce-todo-dependencies t)
(setq org-enforce-todo-checkbox-dependencies t)
(setq org-agenda-span 14)
(setq org-agenda-start-on-weekday nil)


;; latex editing
(require 'pdf-tools)
(setq Tex-auto-save t)
(setq Tex-parse-self t)
(setq-default Tex-master nil)
(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)
(setq TeX-PDF-mode t)
(pdf-tools-install)
(setq org-src-fontify-natively t)

;; git/magit
(use-package magit
    :ensure t
    :init
    (progn
    (bind-key "C-x g" 'magit-status)
    ))

;; stats stuff
(require 'ess)
(require 'ess-site)

;; personal elisp (and ob-stata.el/ess-stata-mode.el)
(add-to-list 'load-path "~/dotfiles/emacs/.emacs.d/lisp")
(require 'ess-stata-mode)
;; (setq-default inferior-STA-program-name "stata-se")
(setq-default inferior-STA-program "stata-se")
(setq-default inferior-STA-start-args "")

;; python
(use-package elpy
  :ensure t
  :init
  (elpy-enable))
(use-package pyvenv
  :ensure t
  :config
  (pyvenv-mode 1))
(add-hook 'inferior-python-mode-hook
          (lambda ()
            (setq comint-move-point-for-output t)))
(with-eval-after-load 'python
  (defun python-shell-completion-native-try ()
    "Return non-nil if can trigger native completion."
    (let ((python-shell-completion-native-enable t)
          (python-shell-completion-native-output-timeout
           python-shell-completion-native-try-output-timeout))
      (python-shell-completion-native-get-completions
       (get-buffer-process (current-buffer))
       nil "_"))))

;;literate programming
(require 'babel)
(setq org-confirm-babel-evaluate nil)
;; Tell emacs location of the directory containing 
;; load ob-stata
(require 'ob-stata)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((stata . t)))
;; Include the latex-exporter
(require 'ox-latex)
(add-to-list 'org-latex-packages-alist '("" "minted"))
(setq org-latex-listings 'minted) 

(setq org-latex-pdf-process
      '("latexmk -shell-escape -interaction=nonstopmode %f"))



;; auto-generated stuff
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(solarized-theme git-timemachine elpy ess ess-R-data-view pdf-tools use-package afternoon-theme alect-themes almost-mono-themes atom-dark-theme auctex auctex-latexmk auctex-lua 0x0 julia-mode julia-repl julia-shell which-key spotify slime rand-theme pylint matlab-mode latexdiff latex-preview-pane latex-pretty-symbols latex-math-preview jupyter jedi gscholar-bibtex flycheck-julia evil dropbox csv conda biblio)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
