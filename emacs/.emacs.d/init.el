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
(setq evil-want-keybinding nil)
(unless (package-installed-p 'evil)
  (package-install 'evil))
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
(set-face-attribute 'default nil :height 140)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1) 
(load-theme 'nord t)
(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative)
(setq inhibit-startup-message t)
(setq inhibit-scratch-message nil)
(setq scroll-conservatively 100)
(require 'hlinum)
(hlinum-activate)
(setq display-line-numbers-type 'relative) 
(visual-line-mode)
(use-package transpose-frame
  :ensure t)
(require 'whitespace)
(autoload 'whitespace-mode "whitespace" "Toggle whitespace visualization." t)

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

;; PDF reading/editing
(use-package pdf-tools
 :pin manual ;; manually update
 :config
 ;; initialise
 (pdf-tools-install)
 ;; open pdfs scaled to fit page
 (setq-default pdf-view-display-size 'fit-page)
 ;; automatically annotate highlights
 (setq pdf-annot-activate-created-annotations t))

;; latex editing
;; (require 'pdf-tools)
(setq Tex-auto-save t)
(setq Tex-parse-self t)
(setq-default Tex-master nil)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)
(setq TeX-PDF-mode t)
(pdf-tools-install)
(setq org-src-fontify-natively t)
(setq TeX-command-force "LaTex")
(defun latex-export-pdf-then-refresh()
  (TeX-command-master))
(defun latex-auto-export-on()
  (interactive)
    (add-hook 'after-save-hook 'latex-export-pdf-then-refresh t t)
    (TeX-command-run-all TeX-command-buffer)
    (windmove-left))

;; git/magit
(use-package magit
    :ensure t
    :init
    (progn
    (bind-key "C-x g" 'magit-status)
    ))

;; stats stuff
(add-to-list 'load-path "/usr/share/emacs/site-lisp/ess/")
(require 'ess)
(require 'ess-site)
(require 'ess-julia)

;; personal elisp (and ob-stata.el/ess-stata-mode.el)
(add-to-list 'load-path "~/dotfiles/emacs/.emacs.d/lisp")
(require 'ess-stata-mode)
(setenv "PATH" (concat (getenv "PATH") ":/usr/local/stata15/"))
(setq-default inferior-STA-program-name "stata")
(setq-default inferior-STA-program "stata")
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
 '((stata . t)
   (latex . t)
   (julia . t)
   (matlab . t)))

;; Include the latex-exporter
(require 'ox-latex)
(add-to-list 'org-latex-packages-alist '("" "minted"))
(setq org-latex-listings 'minted) 

(setq org-latex-pdf-process
      '("latexmk -shell-escape -interaction=nonstopmode %f"))

;; email
(add-to-list 'load-path "~/dotfiles/emacs/.emacs.d/lisp/mu/mu4e")
(require 'mu4e)
(add-to-list 'load-path "~/dotfiles/emacs/.emacs.d/lisp/evil-collection")
(require 'evil-collection)
;; (require 'evil-mu4e)
(add-hook 'mu4e-compose-mode-hook 'turn-on-flyspell)
(add-hook 'mu4e-compose-mode-hook 'turn-on-auto-fill)

;; IRC
(defun start-erc ()
  "Log into freenode with less keystrokes"
  (interactive)
  (let
      ((password-cache nil))
    (erc
     :server "irc.freenode.net"
     :port "6667"
     :nick erc-nick
     :password erc-password)))

;; auto-generated stuff
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#3F3F3F" "#CC9393" "#7F9F7F" "#F0DFAF" "#8CD0D3" "#DC8CC3" "#93E0E3" "#DCDCCC"])
 '(company-quickhelp-color-background "#4F4F4F")
 '(company-quickhelp-color-foreground "#DCDCCC")
 '(custom-safe-themes
   '("37768a79b479684b0756dec7c0fc7652082910c37d8863c35b702db3f16000f8" "f56eb33cd9f1e49c5df0080a3e8a292e83890a61a89bceeaa481a5f183e8e3ef" "ac9c2ccc66816d9b1df9c2e3069107bc4c693796fee0695c3755cf17b4a557d9" "a432688a2f32240644cefb349a2cde2a23e6132b1d1cdb00eff2a683d20765db" "66c1ca3abab40d0969e6c9e1bb0eeee5bbb3d18ff106d97c66338526566b36f4" "a03c1a2781b58dee0d187e83228c290bd5fbf8aa874da16e4cb567e215141b4b" "2a34ae7e2367e837e65b233759dcb752ee3840e0aee5dc160984ccaec33cea5f" "c23f5843026cc10b7e1ce3e0fbde3fc64a83c46c914e4b495f3a271bb015826f" "b4e8e2fe10fc999f612c234bf0c89475b847c3bcdb68ab531bcd1147cd6405a7" "4ee0d893ff450650c2d8f0ca2775de2ee887280295c60741304cd4278bb9d99a" "dca60065cc83efdfbd4547d83ae54f8d76dd8fd98179fd496c276f045bfeb240" "8e981fbb63549b09b2f2f2feb15a14325d2ba6b77f280be14a8a440502aa2bcb" "0458d2319e45ebee051a6d60ceba452c2ea2aca5c87d315ed5f6e42034cd1c67" "b283b2723f1539a4d309f377a22cff61cca146785cbe477fce3bd2ca0331bc8f" "52843ea43e81318c889fccc4b430dc2a4e89aa4ab3b4ce1bb2a5183ea1d9329c" "4392671c44cc0b13b184e1c60426335aec953cea4b974b08f7c9a690a362d92d" "9c965f0a7fcd893a909f3f69f57334af67ff872b9114883ce1825ab0253f8892" default))
 '(fci-rule-color "#383838")
 '(nrepl-message-colors
   '("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3"))
 '(package-selected-packages
   '(linum-off evil-mu4e nord-theme one-themes transpose-frame hlinum solarized-theme git-timemachine elpy ess ess-R-data-view pdf-tools use-package afternoon-theme alect-themes almost-mono-themes atom-dark-theme auctex auctex-latexmk auctex-lua 0x0 julia-repl julia-shell which-key spotify slime rand-theme pylint matlab-mode latexdiff latex-preview-pane latex-pretty-symbols latex-math-preview jupyter jedi gscholar-bibtex flycheck-julia evil dropbox csv conda biblio))
 '(pdf-view-midnight-colors '("#DCDCCC" . "#383838"))
 '(vc-annotate-background "#2B2B2B")
 '(vc-annotate-color-map
   '((20 . "#BC8383")
     (40 . "#CC9393")
     (60 . "#DFAF8F")
     (80 . "#D0BF8F")
     (100 . "#E0CF9F")
     (120 . "#F0DFAF")
     (140 . "#5F7F5F")
     (160 . "#7F9F7F")
     (180 . "#8FB28F")
     (200 . "#9FC59F")
     (220 . "#AFD8AF")
     (240 . "#BFEBBF")
     (260 . "#93E0E3")
     (280 . "#6CA0A3")
     (300 . "#7CB8BB")
     (320 . "#8CD0D3")
     (340 . "#94BFF3")
     (360 . "#DC8CC3")))
 '(vc-annotate-very-old-color "#DC8CC3"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
