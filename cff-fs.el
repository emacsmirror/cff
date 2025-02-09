;;; cff-fs.el --- Search of the C/C++ file header by the source and vice versa -*- lexical-binding: t; -*-

;; Copyright (C) 2025 Alexey Veretennikov
;;
;; Author: Alexey Veretennikov <alexey.veretennikov@gmail.com>
;;
;; Created: 2025-02-09
;;
;; Keywords: find-file
;; Package-Requires: ((cl-lib "0.5") (emacs "25"))
;; URL: https://codeberg.org/fourier/cff
;; Compatibility: GNU Emacs 25.x
;;
;; This file is NOT part of GNU Emacs.
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 2
;; of the License, or (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.
;;
;;; Commentary:

;; Wrapper for cff file system operations

;;; Code:

(eval-when-compile (require 'cl-lib))

;;; File system protocol

;;; Obligatory to implement

(cl-defgeneric cff--fs-directory-files (fs dir)
  "Wrapper around directory-files"
  (directory-files dir))

(cl-defgeneric cff--fs-find-file (fs fname)
  "Wrapper around find-file"
  (find-file fname))

(cl-defgeneric cff--fs-expand-file-name (fs fname)
  "Wrapper around expand-file-name"
  (expand-file-name fname))

(cl-defgeneric cff--fs-file-exists-p (fs fname)
  "Wrapper around file-exists-p"
  (file-exists-p fname))

(cl-defgeneric cff--fs-locate-dominating-file (fs file name)
  "Wrapper around locate-dominating-file"
  (locate-dominating-file file name))

(cl-defgeneric cff--fs-git-ls-files-for-dir (fs repo-dir)
  "Get the list of files in git repo by repo path"
  (split-string         ; split the list of files from string
   ;; run the command to the temp buffer
   (with-temp-buffer
     (call-process "git" nil 't nil
                   "-C" repo-dir "ls-files" "--full-name")
     (buffer-string))))


(provide 'cff-fs)
;;; cff-fs.el ends here
