;;; ord-mode.el --- ORD major mode with optional tree-sitter support -*- lexical-binding: t; -*-

;; SPDX-FileCopyrightText: 2026 ORDeC contributors
;; SPDX-License-Identifier: Apache-2.0

;; Author: Dominik Schwimmbeck <dominik.schwimmbeck@tu-berlin.de>
;; Maintainer: Dominik Schwimmbeck <dominik.schwimmbeck@tu-berlin.de>
;; Version: 0.1.0
;; Keywords: languages
;; Package-Requires: ((emacs "29.1"))
;; URL: https://github.com/schwimmbeck/syntax_highlighting_ordec

;;; Commentary:
;; ORD is a Python-derived language used by ORDeC.  This mode keeps a Python
;; editing baseline even when the local tree-sitter grammars are not installed.
;;
;; Optional tree-sitter setup:
;; - tree-sitter-ord in `ord-mode-treesit-dir'
;; - tree-sitter-python in `ord-mode-python-treesit-dir'
;;
;; When those assets are present and loadable, ORD buffers use Python
;; tree-sitter highlighting as a base, with ORD-specific tree-sitter rules
;; layered on top using :override t to fix ERROR-node artifacts.  Otherwise
;; the mode falls back to ordinary `python-mode' behavior with a small
;; regex-based ORD keyword supplement.

;;; Code:

(require 'python)
(require 'seq)
(require 'subr-x)
(require 'treesit nil t)

(defgroup ord-mode nil
  "Editing support for the ORD language."
  :group 'languages)

(defconst ord-mode--repo-root
  (when-let* ((source-file (or load-file-name (buffer-file-name)))
              (source-dir (file-name-directory (file-truename source-file))))
    (expand-file-name ".." source-dir))
  "Root directory of the syntax_highlighting_ordec checkout when loaded from source.")

(defun ord-mode--first-existing-dir (&rest candidates)
  "Return the first directory from CANDIDATES that exists."
  (seq-find (lambda (dir) (and dir (file-directory-p dir))) candidates))

(defcustom ord-mode-python-treesit-dir
  (ord-mode--first-existing-dir
   (getenv "ORD_MODE_PYTHON_TREESIT_DIR")
   (when ord-mode--repo-root
     (expand-file-name "vendor/tree-sitter-python" ord-mode--repo-root)))
  "Optional path to a local tree-sitter Python grammar directory."
  :type '(choice (const :tag "Disabled" nil) directory)
  :group 'ord-mode)

(defcustom ord-mode-treesit-dir
  (ord-mode--first-existing-dir
   (getenv "ORD_MODE_TREESIT_DIR")
   (when ord-mode--repo-root
     (expand-file-name "tree-sitter-ord" ord-mode--repo-root)))
  "Optional path to a local tree-sitter ORD grammar directory."
  :type '(choice (const :tag "Disabled" nil) directory)
  :group 'ord-mode)

(defcustom ord-mode-emacs-highlights-file nil
  "Optional path to an Emacs-specific tree-sitter highlight query for ORD.
When nil, use `queries/highlights-emacs.scm' under `ord-mode-treesit-dir'."
  :type '(choice (const :tag "Default" nil) file)
  :group 'ord-mode)

(defconst ord-mode--extra-font-lock-keywords
  '(("^\\s-*\\(cell\\)\\s-+\\([[:alpha:]_][[:alnum:]_]*\\)"
     (1 font-lock-keyword-face)
     (2 font-lock-type-face))
    ("^\\s-*\\(viewgen\\)\\s-+\\([[:alpha:]_][[:alnum:]_]*\\)\\(?:.*?->\\s-*\\([[:alpha:]_][[:alnum:]_]*\\)\\)?"
     (1 font-lock-keyword-face)
     (2 font-lock-function-name-face)
     (3 font-lock-type-face nil t))
    ("^\\s-*\\(path\\|net\\)\\b" 1 font-lock-keyword-face)
    ("^\\s-*\\(inout\\|input\\|output\\|port\\)\\b" 1 font-lock-keyword-face)
    ("\\.\\(\\$[[:alpha:]_][[:alnum:]_]*\\)"
     (1 font-lock-variable-name-face))
    ("\\.[[:alpha:]_][[:alnum:]_]*\\s-*\\(--\\)"
     (1 font-lock-keyword-face))
    ("\\(--\\)" 1 font-lock-keyword-face))
  "Fallback regex rules for key ORD declarations.")

(defconst ord-mode--treesit-feature-list
  '((comment definition)
    (keyword string type ord)
    (assignment builtin constant decorator
                escape-sequence number string-interpolation)
    (bracket delimiter function operator variable property))
  "Python tree-sitter features plus the ORD-specific feature group.")

(defvar ord-mode--treesit-font-lock-settings nil
  "Compiled tree-sitter font-lock settings for `ord-mode'.")

(defun ord-mode--default-emacs-highlights-file ()
  "Return the default Emacs highlight query path for ORD."
  (when ord-mode-treesit-dir
    (expand-file-name "queries/highlights-emacs.scm" ord-mode-treesit-dir)))

(defun ord-mode--emacs-highlights-file ()
  "Return the active Emacs highlight query path for ORD."
  (or ord-mode-emacs-highlights-file
      (ord-mode--default-emacs-highlights-file)))

(defun ord-mode--library-present-p (dir language)
  "Return non-nil when DIR appears to contain a shared library for LANGUAGE."
  (when dir
    (directory-files
     dir nil
     (format "libtree-sitter-%s\\..*" (regexp-quote (symbol-name language)))
     t)))

(defun ord-mode--register-grammar-dirs ()
  "Register local tree-sitter grammar directories when present."
  (when (boundp 'treesit-extra-load-path)
    (dolist (entry `((python . ,ord-mode-python-treesit-dir)
                     (ord . ,ord-mode-treesit-dir)))
      (pcase-let ((`(,language . ,dir) entry))
        (when (and dir
                   (file-directory-p dir)
                   (ord-mode--library-present-p dir language))
          (add-to-list 'treesit-extra-load-path dir))))))

(defun ord-mode--compile-treesit-settings ()
  "Compile merged Python and ORD tree-sitter font-lock settings if possible.
ORD rules use :override t so they take precedence over Python ERROR nodes."
  (setq ord-mode--treesit-font-lock-settings nil)
  (let ((highlights-file (ord-mode--emacs-highlights-file)))
    (when (and (featurep 'treesit)
               (fboundp 'treesit-font-lock-rules)
               (boundp 'python--treesit-settings)
               highlights-file
               (file-exists-p highlights-file))
      (setq ord-mode--treesit-font-lock-settings
            (append
             python--treesit-settings
             (treesit-font-lock-rules
              :language 'ord
              :feature 'ord
              :override t
              (with-temp-buffer
                (insert-file-contents highlights-file)
                (buffer-string))))))))

(defun ord-mode--treesit-ready-p ()
  "Return non-nil when both Python and ORD tree-sitter grammars are usable."
  (and (featurep 'treesit)
       (fboundp 'treesit-language-available-p)
       (treesit-language-available-p 'python)
       (treesit-language-available-p 'ord)
       ord-mode--treesit-font-lock-settings))

(defun ord-mode--maybe-enable-treesit ()
  "Enable tree-sitter-based highlighting for the current ORD buffer when possible."
  (when (ord-mode--treesit-ready-p)
    (treesit-parser-create 'python)
    (treesit-parser-create 'ord)
    (setq-local treesit-font-lock-settings ord-mode--treesit-font-lock-settings)
    (setq-local treesit-font-lock-feature-list ord-mode--treesit-feature-list)
    (treesit-major-mode-setup)))

;;;###autoload
(define-derived-mode ord-mode python-mode "Ord"
  "Major mode for editing `.ord' files."
  (setq-local comment-start "# ")
  (setq-local comment-end "")
  (setq-local tab-width 4)
  (setq-local python-indent-offset 4)
  (setq-local python-indent-guess-indent-offset nil)
  (setq-local indent-tabs-mode t)
  (ord-mode--maybe-enable-treesit)
  (unless (ord-mode--treesit-ready-p)
    (font-lock-add-keywords nil ord-mode--extra-font-lock-keywords 'prepend))
  (when (fboundp 'font-lock-flush)
    (font-lock-flush)))

(ord-mode--register-grammar-dirs)
(ord-mode--compile-treesit-settings)

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.ord\\'" . ord-mode))

;; --- LSP integration ---------------------------------------------------------

(defcustom ord-mode-lsp-server-command '("ordec-lsp")
  "Command and arguments used to start the ORD language server."
  :type '(repeat string)
  :group 'ord-mode)

;; Eglot (built-in since Emacs 29).
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               `(ord-mode . ,ord-mode-lsp-server-command)))

;; lsp-mode (optional external package).
(with-eval-after-load 'lsp-mode
  (when (fboundp 'lsp-register-client)
    (lsp-register-client
     (make-lsp-client
      :new-connection (lsp-stdio-connection (lambda () ord-mode-lsp-server-command))
      :activation-fn (lsp-activate-on "ord")
      :server-id 'ordec-lsp
      :priority -1))))

(provide 'ord-mode)
;;; ord-mode.el ends here
