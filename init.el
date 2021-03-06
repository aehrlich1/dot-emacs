;; DO NOT EDIT THIS FILE DIRECTLY
;; This is a file generated from a literate programing source file located at
;; https://github.com/zzamboni/dot-emacs/blob/master/init.org.
;; You should make any changes there and regenerate it from Emacs org-mode using C-c C-v t

(let ((file-name-handler-alist nil))

(add-hook 'emacs-startup-hook
          (lambda ()
            (message "Emacs ready in %s with %d garbage collections."
                     (format "%.2f seconds"
                             (float-time
                              (time-subtract after-init-time before-init-time)))
                     gcs-done)))

;;(setq debug-on-error t)

;; (when (require 'gcmh nil t)
;;   (gcmh-mode 1))

;  (setq gc-cons-threshold most-positive-fixnum)

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(customize-set-variable 'package-archives
                        '(("marmalade" . "https://marmalade-repo.org/packages/")
                          ("melpa"     . "https://melpa.org/packages/")
                          ("elpa"     .  "https://elpa.gnu.org/packages/")))

(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(when (not (package-installed-p 'use-package))
  (package-install 'use-package))

(require 'use-package)

(customize-set-variable 'use-package-always-ensure t)

(customize-set-variable 'use-package-always-defer t)

(customize-set-variable 'use-package-verbose nil)

(use-package quelpa
  :defer nil
  :config
  (quelpa
   '(quelpa-use-package
     :fetcher git
     :url "https://github.com/quelpa/quelpa-use-package.git"))
  (require 'quelpa-use-package))

(customize-set-variable 'load-prefer-newer t)
(use-package auto-compile
  :defer nil
  :config (auto-compile-on-load-mode))

(add-to-list 'load-path "~/.emacs.d/lisp")

(use-package paradox
  :defer nil
  :custom
  (paradox-github-token t)
  :config
  (paradox-enable))

(require 'auth-source)
(require 'auth-source-pass)
(auth-source-pass-enable)

(customize-set-variable 'confirm-kill-processes nil)

(use-package gcmh
  :disabled
  :defer nil
  :custom
  (gcmh-verbose t)
  :config
  (gcmh-mode 1))

(defun zz/set-proxy ()
  (interactive)
  (customize-set-variable 'url-proxy-services
                          '(("http"  . "proxy.corproot.net:8079")
                            ("https" . "proxy.corproot.net:8079"))))
(defun zz/unset-proxy ()
  (interactive)
  (customize-set-variable 'url-proxy-services nil))

(set-language-environment "UTF-8")

(require 'cl)

(use-package async)

(server-start)

(add-hook 'before-save-hook 'time-stamp)

(customize-set-variable 'kill-whole-line t)

(customize-set-variable 'mouse-yank-at-point t)

(setq completion-ignore-case t)
(customize-set-variable 'read-file-name-completion-ignore-case t)
(customize-set-variable 'read-buffer-completion-ignore-case t)

(customize-set-variable 'show-trailing-whitespace nil)

(show-paren-mode)

(customize-set-variable 'indent-tabs-mode nil)

(customize-set-variable
 'backup-directory-alist
 `(("." . ,(concat user-emacs-directory "backups"))))

(when (fboundp 'winner-mode) (winner-mode))

(use-package unfill
  :bind
  ("M-q" . unfill-toggle)
  ("A-q" . unfill-paragraph))

(use-package saveplace
  :defer nil
  :config
  (save-place-mode))

(use-package imenu-anywhere
  :bind
  ("M-i" . helm-imenu-anywhere))

(use-package smooth-scrolling
  :config
  (smooth-scrolling-mode 1))

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(customize-set-variable 'ad-redefinition-action 'accept)

(cond ((eq system-type 'darwin)
       (customize-set-variable 'mac-command-modifier 'meta)
       (customize-set-variable 'mac-option-modifier 'alt)
       (customize-set-variable 'mac-right-option-modifier 'super)
       (bind-key "M-+" 'text-scale-increase)
       (bind-key "M-=" 'text-scale-increase)
       (bind-key "M--" 'text-scale-decrease)
       (defun zz/text-scale-reset ()
         (interactive)
         (text-scale-set 0))
       (bind-key "M-0" 'zz/text-scale-reset)
       (use-package exec-path-from-shell
         :defer nil
         :config
         (exec-path-from-shell-initialize))
       )
      ((eq system-type 'windows-nt)
       
       )
      ((eq system-type 'gnu/linux)
       
       ))

(use-package which-key
  :defer nil
  :diminish which-key-mode
  :config
  (which-key-mode))

(require 'bind-key)

(bind-key "M-g" 'goto-line)

(bind-key "M-`" 'other-frame)

(use-package pcre2el)
(use-package visual-regexp-steroids
  :custom
  (vr/engine 'pcre2el "Use PCRE regular expressions")
  :bind
  ("C-c r" . vr/replace)
  ("C-c q" . vr/query-replace)
  ("C-r"   . vr/isearch-backward)
  ("C-S-s" . vr/isearch-forward)
  ("C-M-s" . isearch-forward)
  ("C-M-r" . isearch-backward))

(bind-key "M-/" 'hippie-expand)

(defun zz/goto-match-paren (arg)
  "Go to the matching paren/bracket, otherwise (or if ARG is not
  nil) insert %.  vi style of % jumping to matching brace."
  (interactive "p")
  (if (not (memq last-command '(set-mark
                                cua-set-mark
                                zz/goto-match-paren
                                down-list
                                up-list
                                end-of-defun
                                beginning-of-defun
                                backward-sexp
                                forward-sexp
                                backward-up-list
                                forward-paragraph
                                backward-paragraph
                                end-of-buffer
                                beginning-of-buffer
                                backward-word
                                forward-word
                                mwheel-scroll
                                backward-word
                                forward-word
                                mouse-start-secondary
                                mouse-yank-secondary
                                mouse-secondary-save-then-kill
                                move-end-of-line
                                move-beginning-of-line
                                backward-char
                                forward-char
                                scroll-up
                                scroll-down
                                scroll-left
                                scroll-right
                                mouse-set-point
                                next-buffer
                                previous-buffer
                                previous-line
                                next-line
                                back-to-indentation
                                )))
      (self-insert-command (or arg 1))
    (cond ((looking-at "\\s\(") (sp-forward-sexp) (backward-char 1))
          ((looking-at "\\s\)") (forward-char 1) (sp-backward-sexp))
          (t (self-insert-command (or arg 1))))))

(bind-key "%" 'zz/goto-match-paren)

(use-package org
  :pin manual
  :load-path ("lisp/org-mode/lisp" "lisp/org-mode/lisp/contrib/lisp")
  :bind
  (:map org-mode-map
        ("C-c l" . org-store-link)
        ("A-h" . org-mark-element)
        ("C-a" . org-beginning-of-line)
        ("C-e" . org-end-of-line)
        ("C-k" . org-kill-line))
  :custom
    (org-directory "~/Dropbox/Personal/org")
    (org-log-done t)
    (org-startup-indented t)
    (org-log-into-drawer t)
    (org-special-ctrl-a/e t)
    (org-special-ctrl-k t)
    (org-use-speed-commands
     (lambda ()
       (and (looking-at org-outline-regexp)
            (looking-back "^\**"))))
    (org-confirm-babel-evaluate nil)
    (org-src-fontify-natively t)
    (org-src-tab-acts-natively t)
    (org-hide-emphasis-markers t)
    (org-fontify-done-headline t)
    (org-tags-column 0)
    (org-todo-keyword-faces
     '(("AREA"         . "DarkOrchid1")
       ("[AREA]"       . "DarkOrchid1")
       ("PROJECT"      . "DarkOrchid1")
       ("[PROJECT]"    . "DarkOrchid1")
       ("INBOX"        . "cyan")
       ("[INBOX]"      . "cyan")
       ("PROPOSAL"     . "orange")
       ("[PROPOSAL]"   . "orange")
       ("DRAFT"        . "yellow3")
       ("[DRAFT]"      . "yellow3")
       ("INPROGRESS"   . "yellow4")
       ("[INPROGRESS]" . "yellow4")
       ("MEETING"      . "purple")
       ("[MEETING]"    . "purple")
       ("CANCELED"     . "blue")
       ("[CANCELED]"   . "blue")))
  :custom-face
    (variable-pitch ((t (:family "ETBembo" :height 180 :weight thin))))
    ;;(variable-pitch ((t (:family "Avenir Next" :height 160 :weight light))))
    (fixed-pitch ((t (:family "Inconsolata Nerd Font"))))
    (org-indent ((t (:inherit (org-hide fixed-pitch)))))
    (org-done ((t (:foreground "PaleGreen"
                               :strike-through t))))
  :hook
    (org-mode . (lambda () (add-hook 'after-save-hook 'org-babel-tangle :append :local)))
    (org-babel-after-execute . org-redisplay-inline-images)
    (org-mode . visual-line-mode)
    (org-mode . variable-pitch-mode)
    (org-mode . (lambda ()
                  "Beautify Org Checkbox Symbol"
                  (push '("[ ]" . "☐" ) prettify-symbols-alist)
                  (push '("[X]" . "☑" ) prettify-symbols-alist)
                  (push '("[-]" . "⊡" ) prettify-symbols-alist)
                  (prettify-symbols-mode)))
  :config
    (org-babel-do-load-languages
     'org-babel-load-languages
     '((cfengine3 . t)
       (ruby      . t)
       (latex     . t)
       (plantuml  . t)
       (python    . t)
       (shell     . t)
       (elvish    . t)
       (calc      . t)
       (dot       . t)
       (ditaa     . t)
       (org       . t)))
    (font-lock-add-keywords
     'org-mode
     '(("^ *\\([-]\\) "
        (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))
    (let* ((variable-tuple
            (cond ((x-list-fonts   "ETBembo")         '(:font   "ETBembo"))
                  ((x-list-fonts   "Source Sans Pro") '(:font   "Source Sans Pro"))
                  ((x-list-fonts   "Lucida Grande")   '(:font   "Lucida Grande"))
                  ((x-list-fonts   "Verdana")         '(:font   "Verdana"))
                  ((x-family-fonts "Sans Serif")      '(:family "Sans Serif"))
                  (nil (warn "Cannot find a Sans Serif Font."))))
           (base-font-color (face-foreground 'default nil 'default))
           (headline `(:inherit default :weight bold
                                :foreground ,base-font-color)))
    
      (custom-theme-set-faces
       'user
       `(org-level-8        ((t (,@headline ,@variable-tuple))))
       `(org-level-7        ((t (,@headline ,@variable-tuple))))
       `(org-level-6        ((t (,@headline ,@variable-tuple))))
       `(org-level-5        ((t (,@headline ,@variable-tuple))))
       `(org-level-4        ((t (,@headline ,@variable-tuple :height 1.1))))
       `(org-level-3        ((t (,@headline ,@variable-tuple :height 1.25))))
       `(org-level-2        ((t (,@headline ,@variable-tuple :height 1.5))))
       `(org-level-1        ((t (,@headline ,@variable-tuple :height 1.75))))
       `(org-headline-done  ((t (,@headline ,@variable-tuple :strike-through t))))
       `(org-document-title ((t (,@headline ,@variable-tuple
                                            :height 2.0 :underline nil))))))
    (eval-after-load 'face-remap '(diminish 'buffer-face-mode))
    (eval-after-load 'simple '(diminish 'visual-line-mode))
    (defface org-checkbox-done-text
      '((t (:foreground "#71696A" :strike-through t)))
      "Face for the text part of a checked org-mode checkbox.")
    
    (font-lock-add-keywords
     'org-mode
     `(("^[ \t]*\\(?:[-+*]\\|[0-9]+[).]\\)[ \t]+\\(\\(?:\\[@\\(?:start:\\)?[0-9]+\\][ \t]*\\)?\\[\\(?:X\\|\\([0-9]+\\)/\\2\\)\\][^\n]*\n\\)"
        1 'org-checkbox-done-text prepend))
     'append))

(use-package org-indent
  :ensure nil
  :diminish
  :custom
  (org-indent-indentation-per-level 4))

(use-package org-agenda
  :ensure nil
  :after org
  :bind
  ("C-c a" . org-agenda)
  :custom
  (org-agenda-include-diary t)
  (org-agenda-prefix-format '((agenda . " %i %-12:c%?-12t% s")
                              ;; Indent todo items by level to show nesting
                              (todo . " %i %-12:c%l")
                              (tags . " %i %-12:c")
                              (search . " %i %-12:c")))
  (org-agenda-start-on-weekday nil))

(use-package mexican-holidays
  :defer nil)

(quelpa '(swiss-holidays :fetcher github :repo "egli/swiss-holidays"))
(require 'swiss-holidays)

(use-package holidays
  :defer nil
  :ensure nil
  :init
  (require 'mexican-holidays)
  :config
  (setq calendar-holidays
        (append '((holiday-fixed 1 1 "New Year's Day")
                  (holiday-fixed 2 14 "Valentine's Day")
                  (holiday-fixed 4 1 "April Fools' Day")
                  (holiday-fixed 10 31 "Halloween")
                  (holiday-easter-etc)
                  (holiday-fixed 12 25 "Christmas")
                  (solar-equinoxes-solstices))
                swiss-holidays
                swiss-holidays-catholic
                swiss-holidays-zh-city-holidays
                holiday-mexican-holidays)))

(require 'org-habit)
(use-package org-super-agenda
  :defer nil
  :custom
  (org-super-agenda-groups '((:auto-dir-name t)))
  :config
  (org-super-agenda-mode))

(use-package org-archive
  :ensure nil
  :custom
  (org-archive-location "archive.org::datetree/"))

(defun zz/add-file-keybinding (key file &optional desc)
  (lexical-let ((key key)
                (file file)
                (desc desc))
    (global-set-key (kbd key) (lambda () (interactive) (find-file file)))
    (which-key-add-key-based-replacements key (or desc file))))

(zz/add-file-keybinding "C-c f w" "~/Work/work.org.gpg" "work.org")
(zz/add-file-keybinding "C-c f p" "~/org/projects.org" "projects.org")
(zz/add-file-keybinding "C-c f i" "~/org/ideas.org" "ideas.org")
(zz/add-file-keybinding "C-c f d" "~/org/diary.org" "diary.org")

(use-package org-capture
  :ensure nil
  :after org
  :defer 1
  :bind
  ("C-c c" . org-capture)
  :config
  (defun org-hugo-new-subtree-post-capture-template ()
    "Returns `org-capture' template string for new Hugo post.
  See `org-capture-templates' for more information."
    (let* ((title (read-from-minibuffer "Post Title: "))
           (fname (org-hugo-slug title)))
      (mapconcat #'identity
                 `(,(concat "* TODO " title)
                   ":PROPERTIES:"
                   ,(concat ":EXPORT_HUGO_BUNDLE: " fname)
                   ":EXPORT_FILE_NAME: index"
                   ":END:"
                   "%?\n") ; Place the cursor here finally
                 "\n")))
  (add-to-list 'org-capture-templates
               '("z"       ;`org-capture' binding + z
                 "zzamboni.org post"
                 entry
                 ;; It is assumed that below file is present in `org-directory'
                 ;; and that it has an "Ideas" heading. It can even be a
                 ;; symlink pointing to the actual location of all-posts.org!
                 (file+olp "zzamboni.org" "Ideas")
                 (function org-hugo-new-subtree-post-capture-template)))
  )

(use-package emacsql
  :defer nil)
(use-package emacsql-sqlite
  :after emacsql
  :defer nil)

(use-package org-roam
  :after (org emacsql emacsql-sqlite)
  :load-path "lisp/org-roam"
  :diminish
  :hook
  ((org-mode . org-roam-mode)
   (after-init . org-roam--build-cache-async))
  :custom
  (org-roam-directory "~/Dropbox/Personal/org")
  :bind
  ("C-c n l" . org-roam)
  ("C-c n t" . org-roam-today)
  ("C-c n f" . org-roam-find-file)
  ("C-c n i" . org-roam-insert)
  ("C-c n g" . org-roam-show-graph))

(use-package deft
  :after org
  :bind
  ("C-c n d" . deft)
  :custom
  (deft-directory org-directory)
  (deft-recursive t)
  (deft-use-filename-as-title nil)
  (deft-use-filter-string-for-filename t)
  (deft-file-naming-rules '((noslash . "-")
                            (nospace . "-")
                            (case-fn . downcase)))
  (deft-org-mode-title-prefix t)
  (deft-extensions '("org" "txt" "text" "md" "markdown" "org.gpg"))
  (deft-default-extension "org"))

(use-package org-download
  :after org
  :defer nil
  :custom
  (org-download-method 'directory)
  (org-download-image-dir "images")
  :config
  (require 'org-download))

(use-package ox-reveal
  :load-path ("lisp/org-reveal")
  :defer 3
  :after org
  :custom
  (org-reveal-note-key-char nil)
  (org-reveal-root "file:///Users/taazadi1/.emacs.d/lisp/reveal.js"))
(use-package htmlize
  :defer 3
  :after ox-reveal)

(use-package ox-html
  :ensure nil
  :defer 3
  :after org
  :custom
  (org-html-checkbox-type 'unicode))

(use-package ox-md
  :ensure nil
  :defer 3
  :after org)

(use-package ox-gfm
  :defer 3
  :after org)

(use-package ox-jira
  :defer 3
  :after org)

(use-package org-jira
  :defer 3
  :after org
  :custom
  (jiralib-url "https://jira.swisscom.com"))

(use-package ox-confluence
  :defer 3
  :ensure nil
  :after org)

(use-package ox-asciidoc
  :defer 3
  :after org)

(use-package ox-texinfo
  :load-path "lisp/org-mode/lisp"
  :defer 3
  :ensure nil
  :after org)

(use-package ox-latex
  :load-path "lisp/org-mode/lisp"
  :ensure nil
  :demand
  :after org
  :custom
  (org-latex-compiler "xelatex")
  ;; (org-latex-pdf-process
  ;;  '("%latex -shell-escape -interaction nonstopmode -output-directory %o %f"
  ;;    "%latex -interaction nonstopmode -output-directory %o %f"
  ;;    "%latex -interaction nonstopmode -output-directory %o %f"))
  :config
  ;; (setq org-latex-listings 'minted)
  ;; (add-to-list 'org-latex-packages-alist '("newfloat" "minted"))
  ;; (add-to-list 'org-latex-minted-langs '(lua "lua"))
  ;; (add-to-list 'org-latex-minted-langs '(shell "shell"))
  (add-to-list 'org-latex-classes
               '("book-no-parts" "\\documentclass[11pt,letterpaper]{book}"
                 ("\\chapter{%s}" . "\\chapter*{%s}")
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")))
  ;; Necessary for LuaLaTeX to work - see
  ;; https://tex.stackexchange.com/a/374391/10680
  (setenv "LANG" "en_US.UTF-8"))

(use-package ox-clip
  :bind
  ("A-C-M-k" . ox-clip-formatted-copy))

(use-package ox-awesomecv
  :load-path "~/.emacs.d/lisp/org-cv"
  :init
  (require 'ox-awesomecv))
(use-package ox-hugocv
  :disabled
  :load-path "~/.emacs.d/lisp/org-cv"
  :init
  (require 'ox-hugocv))

(use-package ox-org
  :ensure nil
  :defer 3
  :after org)

(use-package ox-hugo
  :defer 3
  :after org
  ;; Testing hooks to automatically set the filename on an ox-hugo
  ;; blog entry when it gets marked as DONE
  ;; :hook
  ;; (org-mode . (lambda ()
  ;;               (add-hook 'org-after-todo-state-change-hook
  ;;                         (lambda ()
  ;;                           (org-set-property
  ;;                            "testprop"
  ;;                            (concat "org-state: " org-state
  ;;                                    " prev-state: " (org-get-todo-state))))
  ;;                         'run-at-end 'only-in-org-mode)))
  )

(use-package epa-file
    :ensure nil ;; included with Emacs
    :config
    (setq epa-file-encrypt-to '("diego@zzamboni.org"))
;    (epa-file-enable)
    :custom
    (epa-file-select-keys 'silent))

(use-package org-crypt
  :ensure nil  ;; included with org-mode
  :after org
  :config
  (org-crypt-use-before-save-magic)
  (setq org-tags-exclude-from-inheritance (quote ("crypt")))
  :custom
  (org-crypt-key "diego@zzamboni.org"))

(use-package org-journal
  :after org
  :custom
  (org-journal-dir (concat (file-name-as-directory org-directory) "journal"))
  (org-journal-file-format "%Y/%m/%Y%m%d")
  (org-journal-date-format "%A, %Y-%m-%d")
  (org-journal-encrypt-journal t)
  (org-journal-enable-encryption nil)
  (org-journal-enable-agenda-integration t)
  :bind
  ("C-c j" . org-journal-new-entry))

(use-package ob-cfengine3
  :after org)

(use-package ob-elvish
  :after org)

(require 'subr-x)
(setq homebrew-plantuml-jar-path
      (expand-file-name
       (string-trim
        (shell-command-to-string "brew list plantuml | grep jar"))))

(use-package plantuml-mode
  :custom
  (plantuml-jar-path homebrew-plantuml-jar-path))

(use-package ob-plantuml
  :ensure nil
  :after org
  :custom
  (org-plantuml-jar-path homebrew-plantuml-jar-path))

(defalias 'console-mode 'shell-script-mode)

(defun zz/org-babel-tangle-async (file)
  "Invoke `org-babel-tangle-file' asynchronously."
  (message "Tangling %s..." (buffer-file-name))
  (async-start
   (let ((args (list file)))
     `(lambda ()
        (require 'org)
        ;;(load "~/.emacs.d/init.el")
        (let ((start-time (current-time)))
          (apply #'org-babel-tangle-file ',args)
          (format "%.2f" (float-time (time-since start-time))))))
   (let ((message-string (format "Tangling %S completed after " file)))
     `(lambda (tangle-time)
        (message (concat ,message-string
                         (format "%s seconds" tangle-time)))))))

(defun zz/org-babel-tangle-current-buffer-async ()
  "Tangle current buffer asynchronously."
  (zz/org-babel-tangle-async (buffer-file-name)))

(use-package org-bullets
  :after org
  :hook
  (org-mode . (lambda () (org-bullets-mode 1))))

(defun zz/write ()
  (interactive)
  ;; Line spacing
  (setq line-spacing 0.1)
  ;; Top padding
  (setq header-line-format " ")
  ;; Hide modeline
  (hide-mode-line-mode)
  ;;(setq mode-line-format nil)
  ;; Side padding
  (setq left-margin-width 2)
  (setq right-margin-width 2)
  (set-window-buffer nil (current-buffer)))

(use-package hide-mode-line)

(use-package toc-org
  :after org
  :hook
  (org-mode . toc-org-enable))

(use-package org-mac-link
  :ensure nil
  :load-path "lisp/org-mode/contrib/lisp"
  :after org
  :bind (:map org-mode-map
              ("C-c g" . org-mac-grab-link)))

(defun zz/org-reformat-buffer ()
  (interactive)
  (when (y-or-n-p "Really format current buffer? ")
    (let ((document (org-element-interpret-data (org-element-parse-buffer))))
      (erase-buffer)
      (insert document)
      (goto-char (point-min)))))

(defun afs/org-remove-link ()
    "Replace an org link by its description or if empty its address"
  (interactive)
  (if (org-in-regexp org-bracket-link-regexp 1)
      (let ((remove (list (match-beginning 0) (match-end 0)))
        (description (if (match-end 3)
                 (org-match-string-no-properties 3)
                 (org-match-string-no-properties 1))))
    (apply 'delete-region remove)
    (insert description))))
(bind-key "C-c C-M-u" 'afs/org-remove-link)

(defun zz/org-if-str (str &optional desc)
  (when (org-string-nw-p str)
    (or (org-string-nw-p desc) str)))

(defun zz/org-macro-hsapi-code (module &optional func desc)
  (org-link-make-string
   (concat "https://www.hammerspoon.org/docs/"
           (concat module (zz/org-if-str func (concat "#" func))))
   (or (org-string-nw-p desc)
       (format "=%s="
               (concat module
                       (zz/org-if-str func (concat "." func)))))))

(defun zz/org-macro-keys-code-outer (str)
  (mapconcat (lambda (s)
               (concat "~" s "~"))
             (split-string str)
             (concat (string ?\u200B) "+" (string ?\u200B))))
(defun zz/org-macro-keys-code-inner (str)
  (concat "~" (mapconcat (lambda (s)
                           (concat s))
                         (split-string str)
                         (concat (string ?\u200B) "-" (string ?\u200B)))
          "~"))
(defun zz/org-macro-keys-code (str)
  (zz/org-macro-keys-code-inner str))

(defun zz/org-macro-luadoc-code (func &optional section desc)
  (org-link-make-string
   (concat "https://www.lua.org/manual/5.3/manual.html#"
           (zz/org-if-str func section))
   (zz/org-if-str func desc)))

(defun zz/org-macro-luafun-code (func &optional desc)
  (org-link-make-string
   (concat "https://www.lua.org/manual/5.3/manual.html#"
           (concat "pdf-" func))
   (zz/org-if-str (concat "=" func "()=") desc)))

(defun org-latex-publish-to-latex-and-open (plist file pub-dir)
  (org-open-file (org-latex-publish-to-pdf plist file pub-dir)))

(use-package ox-leanpub-markdown
  :defer 1
  :ensure nil
  :after org
  :load-path "lisp/ox-leanpub")

(use-package ox-leanpub-markua
  :defer 1
  :ensure nil
  :after org
  :load-path "lisp/ox-leanpub")

(use-package ox-leanpub-book
  :defer 1
  :ensure nil
  :after ox-leanpub-markdown
  :load-path "lisp/ox-leanpub"
  :config
  (progn (org-leanpub-book-setup-menu-markdown)
         (org-leanpub-book-setup-menu-markua)))

(defun org-get-keyword (key)
  (org-element-map (org-element-parse-buffer 'element) 'keyword
    (lambda (k)
      (when (string= key (org-element-property :key k))
        (org-element-property :value k)))
    nil t))

(use-package org-sidebar)

(when (>= emacs-major-version 26)
  (pixel-scroll-mode))

(use-package diminish
  :defer 1)

;;(use-package solarized-theme)
;;(use-package darktooth-theme)
;;(use-package kaolin-themes)
;;(use-package gruvbox-theme)
(use-package spacemacs-theme)
(load-theme 'spacemacs-light)

(use-package smart-mode-line
  :defer 2
  :config
  (sml/setup)
  :custom
  (sml/theme 'respectful)
  (sml/replacer-regexp-list
   '(("^~/\\.emacs\\.d/elpa/"                            ":ELPA:")
     ("^~/\\.emacs\\.d/"                                 ":ED:")
     ("^/sudo:.*:"                                       ":SU:")
     ("^~/Documents/"                                    ":Doc:")
     ("^:\\([^:]*\\):Documento?s/"                       ":\\1/Doc:")
     ("^~/Dropbox/"                                      ":DB:")
     ("^:DB:org"                                         ":Org:")
     ("^:DB:Personal/"                                   ":P:")
     ("^:DB:Personal/writing/"                           ":Write:")
     ("^:P:devel/"                                       ":Dev:")
     ("^:Write:learning-cfengine-3/learning-cfengine-3/" ":cf-learn:")
     ("^:Dev:go/src/github.com/elves/elvish/"            ":elvish:")
     ("^:Dev:zzamboni.org/zzamboni.org/"                 ":zz.org:"))))

(use-package desktop
  :defer nil
  :custom
  (desktop-restore-eager   1 "Restore the first buffer right away")
  (desktop-lazy-idle-delay 1 "Restore the other buffers 1 second later")
  (desktop-lazy-verbose  nil "Be silent about lazily opening buffers")
  :bind
  ("C-M-s-k" . desktop-clear)
  :config
  (desktop-save-mode))

(use-package uniquify
  :defer 1
  :ensure nil
  :custom
  (uniquify-after-kill-buffer-p t)
  (uniquify-buffer-name-style 'post-forward)
  (uniquify-strip-common-suffix t))

(use-package hl-line
  :disabled
  :defer nil
  :config
  (defun zz/get-visual-line-range ()
    (let (b e)
      (save-excursion
        (beginning-of-visual-line)
        (setq b (point))
        (end-of-visual-line)
        (setq e (+ 1 (point)))
        )
      (cons b e)))
  (setq hl-line-range-function #'zz/get-visual-line-range)
  (global-hl-line-mode))

(use-package col-highlight
  :disabled
  :defer nil
  :config
  (col-highlight-toggle-when-idle)
  (col-highlight-set-interval 2))
(use-package crosshairs
  :disabled
  :defer nil
  :config
  (crosshairs-mode))

(use-package recentf
  :defer 1
  :custom
  (recentf-max-menu-items 100)
  (recentf-max-saved-items 100)
  :init
  (recentf-mode))

(use-package ibuffer
  :disabled
  :bind
  ("C-x C-b" . ibuffer))

(use-package smex
  :disabled
  :bind (("M-x" . smex))
  :config (smex-initialize))

(use-package midnight
  :defer 3
  :config
  (setq midnight-period 7200)
  (midnight-mode 1))

(use-package writeroom-mode)

(use-package neotree
  :custom
  (neo-theme (if (display-graphic-p) 'icons 'arrow))
  (neo-smart-open t)
  (projectile-switch-project-action 'neotree-projectile-action)
  :config
  (defun neotree-project-dir ()
    "Open NeoTree using the git root."
    (interactive)
    (let ((project-dir (projectile-project-root))
          (file-name (buffer-file-name)))
      (neotree-toggle)
      (if project-dir
          (if (neo-global--window-exists-p)
              (progn
                (neotree-dir project-dir)
                (neotree-find file-name)))
        (message "Could not find git project root."))))
  :bind
  ([f8] . neotree-project-dir))

(use-package wc-mode
  :defer 3
  :hook
  (org-journal-mode . wc-mode))

(use-package all-the-icons
  :defer 3)

(use-package ido
  :disabled
  :config
  (ido-mode t)
  (ido-everywhere 1)
  (setq ido-use-virtual-buffers t)
  (setq ido-enable-flex-matching t)
  (setq ido-use-filename-at-point nil)
  (setq ido-auto-merge-work-directories-length -1))

(use-package ido-completing-read+
  :disabled
  :config
  (ido-ubiquitous-mode 1))

(use-package helm
  :defer 1
  :diminish helm-mode
  :bind
  (("C-x C-f"       . helm-find-files)
   ("C-x C-b"       . helm-buffers-list)
   ("C-x b"         . helm-multi-files)
   ("M-x"           . helm-M-x)
   :map helm-find-files-map
   ("C-<backspace>" . helm-find-files-up-one-level)
   ("C-f"           . helm-execute-persistent-action)
   ([tab]           . helm-ff-RET))
  :config
  (defun daedreth/helm-hide-minibuffer ()
    (when (with-helm-buffer helm-echo-input-in-header-line)
      (let ((ov (make-overlay (point-min) (point-max) nil nil t)))
        (overlay-put ov 'window (selected-window))
        (overlay-put ov 'face
                     (let ((bg-color (face-background 'default nil)))
                       `(:background ,bg-color :foreground ,bg-color)))
        (setq-local cursor-type nil))))
  (add-hook 'helm-minibuffer-set-up-hook 'daedreth/helm-hide-minibuffer)
  (setq helm-autoresize-max-height 0
        helm-autoresize-min-height 40
        helm-M-x-fuzzy-match t
        helm-buffers-fuzzy-matching t
        helm-recentf-fuzzy-match t
        helm-semantic-fuzzy-match t
        helm-imenu-fuzzy-match t
        helm-split-window-in-side-p nil
        helm-move-to-line-cycle-in-source nil
        helm-ff-search-library-in-sexp t
        helm-scroll-amount 8
        helm-echo-input-in-header-line nil
        completion-styles '(helm-flex))
  :init
  (helm-mode 1))

(require 'helm-config)
(helm-autoresize-mode 1)

(use-package helm-flx
  :custom
  (helm-flx-for-helm-find-files t)
  (helm-flx-for-helm-locate t)
  :config
  (helm-flx-mode +1))

(use-package swiper-helm
  :bind
  ("C-s" . swiper))

(use-package subword
  :hook
  (clojure-mode . subword-mode))

(use-package aggressive-indent
  :disabled
  :diminish aggressive-indent-mode
  :hook
  (prog-mode . aggressive-indent-mode)
  (python-mode . (lambda () (aggressive-indent-mode -1))))

(use-package company
  :diminish company-mode
  :hook
  (after-init . global-company-mode))

(use-package projectile
  :defer 2
  :diminish projectile-mode
  :config
  (projectile-global-mode))

(use-package iedit
  :config
  (set-face-background 'iedit-occurrence "Magenta")
  :bind
  ("C-;" . iedit-mode))

(use-package eldoc
  :diminish
  :hook
  (prog-mode       . turn-on-eldoc-mode)
  (cider-repl-mode . turn-on-eldoc-mode))

(use-package flyspell
  :defer 1
  :diminish)

(use-package clojure-mode
  :mode "\\.clj.*$"
  :mode "riemann.config"
  :mode "\\.boot"
  :config
  (add-to-list 'magic-mode-alist '(".* boot" . clojure-mode)))

(use-package clojure-mode-extra-font-locking)

(use-package cider
  :custom
  ;; nice pretty printing
  (cider-repl-use-pretty-printing nil)
  ;; nicer font lock in REPL
  (cider-repl-use-clojure-font-lock t)
  ;; result prefix for the REPL
  (cider-repl-result-prefix "; => ")
  ;; never ending REPL history
  (cider-repl-wrap-history t)
  ;; looong history
  (cider-repl-history-size 5000)
  ;; persistent history
  (cider-repl-history-file "~/.emacs.d/cider-history")
  ;; error buffer not popping up
  (cider-show-error-buffer nil)
  ;; go right to the REPL buffer when it's finished connecting
  (cider-repl-pop-to-buffer-on-connect t))

(use-package clj-refactor
  :config
  (defun my-clojure-mode-hook ()
    (clj-refactor-mode 1)
    (yas-minor-mode 1) ; for adding require/use/import statements
    ;; This choice of keybinding leaves cider-macroexpand-1 unbound
    (cljr-add-keybindings-with-prefix "C-c C-m"))
  :hook
  (clojure-mode . my-clojure-mode-hook))

(use-package emr
  :config
  (bind-key "A-RET" 'emr-show-refactor-menu prog-mode-map))

(use-package rainbow-delimiters
  :hook
  ((prog-mode cider-repl-mode) . rainbow-delimiters-mode))

(defun zz/sp-enclose-next-sexp (num)
  (interactive "p")
  (insert-parentheses (or num 1)))

(use-package smartparens
  :diminish smartparens-mode
  :config
  (require 'smartparens-config)
  :custom
  (sp-base-key-bindings 'paredit)
  :hook
  ((clojure-mode
    emacs-lisp-mode
    lisp-mode
    cider-repl-mode
    racket-mode
    racket-repl-mode) . smartparens-strict-mode)
  (smartparens-mode  . sp-use-paredit-bindings)
  (smartparens-mode  . (lambda ()
                         (local-set-key (kbd "M-(")
                                        'zz/sp-enclose-next-sexp))))

(use-package hl-sexp
  :hook
  ((clojure-mode lisp-mode emacs-lisp-mode) . hl-sexp-mode))

(use-package lispy
  :disabled
  :config
  (defun enable-lispy-mode () (lispy-mode 1))
  :hook
  ((clojure-mode
    emacs-lisp-mode
    common-lisp-mode
    scheme-mode
    lisp-mode) . enable-lispy-mode))

(use-package cfengine
  :commands cfengine3-mode
  :mode ("\\.cf\\'" . cfengine3-mode))

(use-package cperl-mode
  :mode "\\.p[lm]\\'"
  :interpreter "perl"
  :config
  (setq cperl-hairy t))

(use-package fish-mode
  :mode "\\.fish\\'"
  :interpreter "fish")

(use-package lua-mode)

(use-package yaml-mode)

(use-package applescript-mode)

(use-package go-mode)

(use-package package-build)
(use-package package-lint)

(use-package elvish-mode)

(use-package racket-mode)

(use-package nix-mode)

(use-package dockerfile-mode)

(use-package dhall-mode
  :ensure t
  :mode "\\.dhall\\'")

(require 'rx)
(use-package xr
  :defer nil)

(use-package helm-pass)

(use-package magit
  :diminish auto-revert-mode
  :bind
  (("C-c C-g" . magit-status)
   :map magit-status-mode-map
   ("q"       . magit-quit-session))
  :config
  (defadvice magit-status (around magit-fullscreen activate)
    "Make magit-status run alone in a frame."
    (window-configuration-to-register :magit-fullscreen)
    ad-do-it
    (delete-other-windows))

  (defun magit-quit-session ()
    "Restore the previous window configuration and kill the magit buffer."
    (interactive)
    (kill-buffer)
    (jump-to-register :magit-fullscreen)))

(use-package ag)

(use-package easy-hugo
  :custom
  (easy-hugo-basedir "~/Personal/devel/zzamboni.org/zzamboni.org/")
  (easy-hugo-url "http://zzamboni.org/")
  (easy-hugo-previewtime "300")
  ;;(define-key global-map (kbd "C-c C-e") 'easy-hugo)
  )

(defun my-randomize-region (beg end)
  "Randomize lines in region from BEG to END."
  (interactive "*r")
  (let ((lines (split-string
                (delete-and-extract-region beg end) "\n")))
    (when (string-equal "" (car (last lines 1)))
      (setq lines (butlast lines 1)))
    (apply 'insert
           (mapcar 'cdr
                   (sort (mapcar
                          (lambda (x)
                            (cons (random) (concat x "\n")))
                          lines)
                         (lambda (a b) (< (car a) (car b))))))))

(use-package autoinsert
  :ensure nil
  :custom
  (auto-insert-directory (concat user-emacs-directory "auto-insert/"))
  :hook
  (find-file . auto-insert))

(use-package gist
  :custom
  (gist-view-gist t "Automatically open new gists in browser"))

(use-package esup)

(defmacro measure-time (&rest body)
  "Measure the time it takes to evaluate BODY."
  `(let ((time (current-time)))
     ,@body
     (message "%.06f" (float-time (time-since time)))))

(use-package restart-emacs)

(use-package multiple-cursors
  :bind
  ("C-c m c"   . mc/edit-lines)
  ("C-c m <"   . mc/mark-next-like-this)
  ("C-c m >"   . mc/mark-previous-like-this)
  ("C-c m C-<" . mc/mark-all-like-this))

(use-package lorem-ipsum)

(use-package keybase
  :ensure nil
  :load-path ("lisp/keybase-chat")
  :config (require 'keybase))

(use-package erc
  :custom
  (erc-autojoin-channels-alist '(("freenode.net" "#elvish" "#hammerspoon"
                                  "#org-mode")))
  (erc-autojoin-timing 'ident)
  (erc-fill-function 'erc-fill-static)
  (erc-fill-static-center 22)
  (erc-hide-list '("JOIN" "PART" "QUIT"))
  (erc-lurker-hide-list '("JOIN" "PART" "QUIT"))
  (erc-lurker-threshold-time 43200)
  (erc-nick "zzamboni")
  (erc-prompt-for-nickserv-password nil)
  (erc-server-reconnect-attempts 5)
  (erc-server-reconnect-timeout 3)
  (erc-track-exclude-types '("JOIN" "MODE" "NICK" "PART" "QUIT"
                             "324" "329" "332" "333" "353" "477"))
  :config
  (add-to-list 'erc-modules 'notifications)
  (add-to-list 'erc-modules 'spelling)
  (erc-services-mode 1)
  (erc-update-modules))

(use-package adoc-mode
  :mode "\\.asciidoc\\'"
  :hook
  (adoc-mode . visual-line-mode)
  (adoc-mode . variable-pitch-mode))

(use-package markdown-mode
  :hook
  (markdown-mode . visual-line-mode)
  (markdown-mode . variable-pitch-mode))

(use-package typopunct
  :config
  (typopunct-change-language 'english t))

(use-package undo-tree
  :ensure t
  :diminish undo-tree-mode
  :config
  (global-undo-tree-mode 1))

;; Call this function with "M-x org-multi-file-md-export"
(defun org-multi-file-md-export ()
  "Export current buffer to multiple Markdown files."
  (interactive)
  ;; Loop over all entries in the file
  (org-map-entries
   (lambda ()
     (let* ((level (nth 1 (org-heading-components)))
            (title (or (nth 4 (org-heading-components)) ""))
            ;; Export filename is the EXPORT_FILE_NAME property, or the
            ;; lower-cased section title if it's not set.
            (filename
             (or (org-entry-get (point) "EXPORT_FILE_NAME")
                 (concat (replace-regexp-in-string " " "-" (downcase title)) ".md"))))
       (when (= level 1) ;; export only first level entries
         ;; Mark the subtree so that the title also gets exported
         (org-mark-subtree)
         ;; Call the export function. This is one of the base org
         ;; functions, the 'md defines the backend to use for the
         ;; conversion. For exporting to other formats, simply use the
         ;; correct backend name, and also change the file extension
         ;; above.
         (org-export-to-file 'md filename nil t nil))))
   ;; skip headlines tagged with "noexport" (this is an argument to
   ;; org-map-entries above)
   "-noexport")
  nil nil)

)
