;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")
(setq shell-file-name "/bin/bash")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'modus-operandi)
(setq doom-font (font-spec :family "JetBrains Mono" :size 22)
      doom-variable-pitch-font (font-spec :family "NotoSans" :size 19)
      doom-big-font (font-spec :family "JetBrains Mono" :size 24))
(after! doom-themes
  (setq doom-themes-enable-italic t)
  (setq doom-themes-enable-bold t))
(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))
(after! '(color faces)
  (let ((color (color-darken-name (face-attribute 'default :background) 5)))
    (custom-set-faces!
      `(org-block :background ,color)
      `(org-block-begin-line :background ,color :extend t)
      `(org-block-end-line :background ,color :extend t))))
(set-mouse-color "snow")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/org/"
      org-hide-emphasis-markers t)


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(setq bookmark-save-flag 1)

;; Keybinds
;; Insert " " because of evil mode
(map! :leader "t s" (lambda () (interactive)(insert " ")(org-timestamp-nd-formatted nil "verbatium")))
(map! :leader "o x" #'flexible-scratch-choise)
(map! :leader "SPC" (lambda () (interactive)
                      (if (equal (projectile-project-p) (f-expand "~/"))
                          (princ "Root is $HOME, ignore")
                        (projectile-find-file))))
(add-hook 'dired-after-readin-hook #'zoxide-add-default-dir)

;; (map! :leader
;;       :prefix ("C-v" . "vimish fold")
;;       :desc "Fold region"          "C-f" #'hs-hide-block
;;       :desc "Unfold region"        "C-u" #'hs-show-block
;;       :desc "Delete folded region" "C-d" #'hs-kill-block
;;       (:prefix ("C-a" . "fold all")
;;        :desc "Fold all regions"     "C-f" #'hs-hide-all
;;        :desc "Unfold all regions"   "C-u" #'hs-show-all
;;        :desc "Delete all folded regions" "C-d" #'hs-kill-all))

(map! :leader "C-f" nil)
(map! :leader "C-z" #'dired-zoxide)

(map! :m 'minibuffer-mode-map :g "M-i" #'previous-line)
(map! :m 'minibuffer-mode-map :g "M-o" #'next-line)

;; Tab bar mode
(setq tab-bar-show nil)
(tab-bar-mode t)
(defun tab-bar-toggle-visibility ()
  (interactive)
  (setq tab-bar-show (not tab-bar-show))
  (tab-bar-mode nil)
  (tab-bar-mode t))

;; (use-package! flycheck
;;   (flycheck-disable-checker 'proselint))
;; EDTS

(use-package! erlang
  :config
  ;; I don't know why but when I intall it forked it behaves in a way that requires this shit
  (setq edts-inhibit-package-check t)
  (require 'edts-start)
  (add-hook 'erlang-mode-hook #'auto-complete-mode))

;; Spray mode
(map! :g "<f6>" #'spray-mode)
(add-hook 'spray-mode-hook
          (lambda () (setq spray-margin-top (round (* (window-body-height) 0.25)))
            (setq spray-margin-left (round (* (window-body-width) 0.2)))))
(setq spray-height 250)
(setq spray-wpm 200)

;; Nov.el
(use-package! nov
  :config
  (add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))
  (add-hook 'nov-mode-hook #'visual-line-mode)
  (setq dictionary-default-dictionary "wn")
  (map! :map 'nov-mode-map :g "C-c C-d" (lambda () (interactive)(dictionary-search (word-at-point)))))

;; God mode
(use-package! god-mode
  :if (require 'god-mode nil 'noerror)
  :config
  (setq god-mode-enable-function-key-translation nil)
  (map! :g (kbd "<escape>") #'god-local-mode)
  (require 'god-mode-isearch)
  (map! :map isearch-mode-map :g (kbd "<escape>") #'god-mode-isearch-activate)
  (map! :map god-mode-isearch-map :g (kbd "<escape>") #'god-mode-isearch-disable)
  (map! :map god-local-mode-map :g (kbd ".") #'repeat)
  (map! :g "C-x C-1" #'delete-other-windows)
  (map! :g "C-x C-2" #'split-window-below)
  (map! :g "C-x C-3" #'split-window-right)
  (map! :g "C-x C-0" #'delete-window)
  (map! :map god-local-mode-map :g  "[" #'backward-paragraph)
  (map! :map god-local-mode-map :g "]" #'forward-paragraph)
  (add-hook 'spray-mode-hook
            (if spray-mode (god-local-mode-pause)
              (god-local-mode-resue))))

;; Harpoon
;; (map! :n "C-SPC" 'harpoon-quick-menu-hydra)
;; (map! :n "C-s" 'harpoon-add-file)
;; (map! :leader "j c" 'harpoon-clear)
;; (map! :leader "j f" 'harpoon-toggle-file)
;; (map! :leader "1" 'harpoon-go-to-1)
;; (map! :leader "2" 'harpoon-go-to-2)
;; (map! :leader "3" 'harpoon-go-to-3)
;; (map! :leader "4" 'harpoon-go-to-4)
;; (map! :leader "5" 'harpoon-go-to-5)
;; (map! :leader "6" 'harpoon-go-to-6)
;; (map! :leader "7" 'harpoon-go-to-7)
;; (map! :leader "8" 'harpoon-go-to-8)
;; (map! :leader "9" 'harpoon-go-to-9)
;; Consult
(when (modulep! :completion vertico)
  (map! :map isearch-mode-map :g "C-o" #'my-isearch-consult-line-from-isearch)
  (defun my-isearch-consult-line-from-isearch ()
    "Invoke `consult-line' from isearch."
    (interactive)
    (let ((query (if isearch-regexp
		     isearch-string
		   (regexp-quote isearch-string))))
      (isearch-update-ring isearch-string isearch-regexp)
      (let (search-nonincremental-instead)
        (ignore-errors (isearch-done t t)))
      (consult-line query))))

;; Boon
(use-package! boon
  :if (require 'boon-qwerty nil 'noerror)
  :config
  (boon-mode)
  (map! :map boon-x-map :g "u" 'undo-tree-undo)
  (map! :map boon-x-map :g "U" 'undo-tree-redo)
  (map! :map boon-command-map :g "M-V" 'scroll-up-command)
  (map! :map boon-command-map :g "r" #'consult-line)
  (map! :map boon-select-map :g "S" #'boon-select-sentence)
  (map! :map boon-select-map :g "t" #'boon-select-org-tree)
  (map! :map boon-command-map :g "m" #'zz-half-scroll-forward-with-view)
  (map! :map boon-command-map :g "M" #'zz-half-scroll-backwards-with-view)
  (map! :map boon-x-map :g "s" #'save-buffer)
  (map! :map boon-x-map :g "S" #'save-some-buffers)
  (add-to-list 'boon-special-mode-list 'sly-db-mode)
  (add-hook 'isearch-mode-end-hook #'boon-unhighlight))

(require 'view)
(defun zz-half-scroll-forward-with-view ()
  (interactive)
  (View-scroll-half-page-forward)
  (move-to-window-line (/ (window-body-height) 2)))

(defun zz-half-scroll-backwards-with-view ()
  (interactive)
  (View-scroll-half-page-backward)
  (move-to-window-line (/ (window-body-height) 2)))

(after! sly
  (setq sly-complete-symbol-function 'sly-flex-completions))

;; Meow
(use-package! meow
  :if (require 'meow nil 'noerror)
  :config
  (flet ((meow-setup ()
                     (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)
                     (meow-motion-overwrite-define-key
                      '("j" . meow-next)
                      '("k" . meow-prev)
                      '("<escape>" . ignore))
                     (meow-leader-define-key
                      ;; SPC j/k will run the original command in MOTION state.
                      '("j" . "H-j")
                      '("k" . "H-k")
                      ;; Use SPC (0-9) for digit arguments.
                      '("1" . meow-digit-argument)
                      '("2" . meow-digit-argument)
                      '("3" . meow-digit-argument)
                      '("4" . meow-digit-argument)
                      '("5" . meow-digit-argument)
                      '("6" . meow-digit-argument)
                      '("7" . meow-digit-argument)
                      '("8" . meow-digit-argument)
                      '("9" . meow-digit-argument)
                      '("0" . meow-digit-argument)
                      '("/" . meow-keypad-describe-key)
                      '("?" . meow-cheatsheet))
                     (meow-normal-define-key
                      '("0" . meow-expand-0)
                      '("9" . meow-expand-9)
                      '("8" . meow-expand-8)
                      '("7" . meow-expand-7)
                      '("6" . meow-expand-6)
                      '("5" . meow-expand-5)
                      '("4" . meow-expand-4)
                      '("3" . meow-expand-3)
                      '("2" . meow-expand-2)
                      '("1" . meow-expand-1)
                      '("-" . negative-argument)
                      '(";" . meow-reverse)
                      '("," . meow-inner-of-thing)
                      '("." . meow-bounds-of-thing)
                      '("[" . meow-beginning-of-thing)
                      '("]" . meow-end-of-thing)
                      '("a" . meow-append)
                      '("A" . meow-open-below)
                      '("b" . meow-back-word)
                      '("B" . meow-back-symbol)
                      '("c" . meow-change)
                      '("d" . meow-delete)
                      '("D" . meow-backward-delete)
                      '("e" . meow-next-word)
                      '("E" . meow-next-symbol)
                      '("f" . meow-find)
                      '("g" . meow-cancel-selection)
                      '("G" . meow-grab)
                      '("h" . meow-left)
                      '("H" . meow-left-expand)
                      '("i" . meow-insert)
                      '("I" . meow-open-above)
                      '("j" . meow-next)
                      '("J" . meow-next-expand)
                      '("k" . meow-prev)
                      '("K" . meow-prev-expand)
                      '("l" . meow-right)
                      '("L" . meow-right-expand)
                      '("m" . meow-join)
                      '("n" . meow-search)
                      '("o" . meow-block)
                      '("O" . meow-to-block)
                      '("p" . meow-yank)
                      '("q" . meow-quit)
                      '("Q" . meow-goto-line)
                      '("r" . meow-replace)
                      '("R" . meow-swap-grab)
                      '("s" . meow-kill)
                      '("t" . meow-till)
                      '("u" . meow-undo)
                      '("U" . meow-undo-in-selection)
                      '("v" . meow-visit)
                      '("w" . meow-mark-word)
                      '("W" . meow-mark-symbol)
                      '("x" . meow-line)
                      '("X" . meow-goto-line)
                      '("y" . meow-save)
                      '("Y" . meow-sync-grab)
                      '("z" . meow-pop-selection)
                      '("'" . repeat)
                      '("<escape>" . ignore))))
        (meow-setup)
        (meow-global-mode 1)))

;; org roam
(setq org-roam-directory (file-truename "~/Documents/roam"))
(org-roam-db-autosync-mode)
(add-hook! org-roam-mode (visual-line-mode))

(map! :leader :prefix ("r" . "roam")
      "f" #'org-roam-node-find
      "b" #'org-roam-buffer-toggle
      "e" #'org-roam-extract-subtree
      "d" #'org-roam-dailies-capture-today
      (:prefix ("i" . "insert")
               "i" #'org-roam-node-insert
               "d" #'org-roam-node-insert-with-desc)
      (:prefix ("t" . "tag")
               "a" #'org-roam-tag-add
               "r" #'org-roam-tag-remove)
      (:prefix ("a" . "alias")
               "a" #'org-roam-alias-add
               "r" #'org-roam-alias-remove))



;; Org roam ui
(use-package! websocket
  :after org-roam)
(use-package! org-roam-ui
  :after org-roam ;; or :after org
  ;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
  ;;         a hookable mode anymore, you're advised to pick something yourself
  ;;         if you don't care about startup time, use
  ;;  :hook (after-init . org-roam-ui-mode)
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))


;; Transclusion
(use-package! org-transclusion
  :after org
  :init
  (map! :leader "t a" #'org-transclusion-add)
  (org-transclusion-mode t))
(after! org-roam
  (setq org-roam-db-extra-links-exclude-keys
        '((node-property "ROAM_REFS")))
  (setq org-roam-db-extra-links-elements '(keyword "transclude")))

;; Custom elisp functions
(defun org-insert-code-block ()
  "Interactively ask for language and insert code block at point"
  (interactive)
  (unless (or (equal " " (thing-at-point 'char t))
              (equal nil (thing-at-point 'char t)))
    (end-of-line)
    (newline))
  (insert (concat "#+BEGIN_SRC " (read-string "Language: ") "\n" "\n#+END_SRC"))
  (forward-line -1))

(defun org-inactive-timestamp ()
  "Creates inactive timestamp at point"
  (interactive)
  (org-insert-time-stamp (org-current-time) nil t))

(defun timestamp-no-date (timestamp)
  "Takes in (decode-time) or a list (sec min hour).
   Produces a formatted string HH:MM:SS"
  (let ((hours (time-to-fixed-xx (caddr timestamp)))
        (minutes (time-to-fixed-xx (cadr timestamp)))
        (seconds (time-to-fixed-xx (car timestamp))))
    (format "%s:%s:%s" hours minutes seconds)))

(defun time-to-fixed-xx (time)
  "Converts number to a string and formats it to XX format"
  (if (>= time 10) (prin1-to-string time)
    (concat "0" (prin1-to-string time))))


(defun org-timestamp-nd-formatted (&optional no-brackets style)
  "Inserts a [HH:MM:SS] timestamp with no date at point.
  No-brackets removes brackets. Styles: bold, italic, verbatium, nil"
  (interactive)
  (let ((timestamp (timestamp-no-date (decode-time)))
        (surround (cond ((equal style "bold") "*")
                        ((equal style "italic") "/")
                        ((equal style "verbatium") "=")
                        (t ""))))
    (insert (if no-brackets (format "%s%s%s" surround timestamp surround)
              (format "%s[%s]%s" surround timestamp surround)))))

(defun org-roam-node-insert-with-desc ()
  "Looks up a roam node and inserts the link with specified description.
   The description is specified via prompt."
  (interactive)
  (let ((id (org-roam-node-id (org-roam-node-read)))
        (description (read-string "Description:")))
    (insert (format "[[id:%s][%s]]" id description))))

(defun flexible-scratch (&optional mode)
  "Creates or switches to *scratch* buffer with specified mode.
   Org mode is the default."
  (interactive)
  (let* ((mode (or mode "org"))
         (name (concat "*" mode "-scratch*"))
         (mode (symbol-function (intern-soft (concat mode "-mode"))))
         (buffer (get-buffer-create name)))
    (with-current-buffer buffer (funcall mode))
    (set-window-buffer nil buffer)))

(defun flexible-scratch-choise ()
  (interactive)
  (flexible-scratch (cadr (read-multiple-choice "Which mode?"
                                                '((?1 "org")
                                                  (?2 "text")
                                                  (?3 "common-lisp")
                                                  (?4 "lisp-interaction"))))))
(defun zoxide--get-dir-list (query)
  (let* ((query-list (s-split-words query))
         (dir-list (apply #'process-lines "zoxide" "query" "-l" query-list)))
    (list (nth 0 dir-list) (nth 1 dir-list))))

(defun dired-zoxide ()
  (interactive)
  (let* ((query (read-string "z: "))
         (dir-list (zoxide--get-dir-list query)))
    (when (equal nil (car dir-list))
      (message "Directory \"%s\" not found" query))
    (dired-zoxide-cd dir-list)))

(defun dired-zoxide-cd (dir-list)
  (when (equal 1 (length dir-list)) (dired (car dir-list)))
  (if (equal default-directory (concat (car dir-list) (f-path-separator)))
      (dired (cdr dir-list))
    (dired (car dir-list))))

(defun zoxide-add-default-dir ()
  (process-lines "zoxide" "add" default-directory)
  (message "added %s" default-directory))
