;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

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
(setq doom-theme 'doom-one)
(setq doom-font (font-spec :family "JetBrains Mono" :size 18)
      doom-variable-pitch-font (font-spec :family "NotoSans" :size 19)
      doom-big-font (font-spec :family "JetBrains Mono" :size 24))
(after! doom-themes
  (setq doom-themes-enable-italic t)
  (setq doom-themes-enable-bold t))
(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))
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

;;Keybinds
(map! :leader "t s" (lambda () (interactive)(org-timestamp-nd-formatted nil "verbatium")))

;;Harpoon
(map! :n "C-SPC" 'harpoon-quick-menu-hydra)
(map! :n "C-s" 'harpoon-add-file)
(map! :leader "j c" 'harpoon-clear)
(map! :leader "j f" 'harpoon-toggle-file)
(map! :leader "1" 'harpoon-go-to-1)
(map! :leader "2" 'harpoon-go-to-2)
(map! :leader "3" 'harpoon-go-to-3)
(map! :leader "4" 'harpoon-go-to-4)
(map! :leader "5" 'harpoon-go-to-5)
(map! :leader "6" 'harpoon-go-to-6)
(map! :leader "7" 'harpoon-go-to-7)
(map! :leader "8" 'harpoon-go-to-8)
(map! :leader "9" 'harpoon-go-to-9)
;;Org roam
(setq org-roam-directory (file-truename "~/Documents/roam"))
(org-roam-db-autosync-mode)
(add-hook! org-roam-mode (visual-line-mode))
(map! :leader "r i" #'org-roam-node-insert)
(map! :leader "r f" #'org-roam-node-find)
(map! :leader "r b" #'org-roam-buffer-toggle)
(map! :leader "r e" #'org-roam-extract-subtree)
(map! :leader "r t a" #'org-roam-tag-add)
(map! :leader "r t r" #'org-roam-tag-remove)
;;Org roam ui
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
;;Transclusion
(use-package! org-transclusion
  :after org
  :init
  (map! :leader "t a" #'org-transclusion-add)
  (org-transclusion-mode t))
(after! org-roam
  (setq org-roam-db-extra-links-exclude-keys
        '((node-property "ROAM_REFS")))
  (setq org-roam-db-extra-links-elements '(keyword "transclude")))
;; reverse-im
(reverse-im-mode t)
;;custom elisp functions
(defun org-insert-code-block ()
  ;; Interactively ask for language and insert code block at point
  (interactive)
  (unless (or (equal " " (thing-at-point 'char t))
              (equal nil (thing-at-point 'char t)))
    (end-of-line)
    (newline))
  (insert (concat "#+BEGIN_SRC " (read-string "Language: ") "\n" "\n#+END_SRC"))
  (forward-line -1))

(defun org-inactive-timestamp ()
  ;; Creates inactive timestamp at point
  (interactive)
  (org-insert-time-stamp (org-current-time) nil t))

(defun timestamp-no-date (timestamp)
  ;; Takes in (decode-time) or a list (sec min hour) and produces a formatted string HH:MM:SS
  (let ((hours (time-to-fixed-xx (caddr timestamp)))
        (minutes (time-to-fixed-xx (cadr timestamp)))
        (seconds (time-to-fixed-xx (car timestamp))))
    (format "%s:%s:%s" hours minutes seconds)))

(defun time-to-fixed-xx (time)
  ;; Converts number to a string and formats it to XX format
  (if (>= time 10) (prin1-to-string time)
    (concat "0" (prin1-to-string time)))
  )


(defun org-timestamp-nd-formatted (&optional no-brackets style)
  ;; Inserts a [HH:MM:SS] timestamp with no date at point
  ;; no-brackets removes brackets.
  ;; Styles: bold, italic, verbatium, nil
  (interactive)
  (let ((timestamp (timestamp-no-date (decode-time)))
        (surround (cond ((equal style "bold") "*")
                        ((equal style "italic") "/")
                        ((equal style "verbatium") "=")
                        (t ""))))
    (insert (if no-brackets (format "%s%s%s" surround timestamp surround)
              (format "%s[%s]%s" surround timestamp surround))))
  )
