;;; ob-C-stdin.el --- :stdin for org-bable-C  -*- lexical-binding:t -*-

;; Copyright (C) 2023-present CHEN Xian'an (a.k.a `realazy').

;; Maintainer: xianan.chen@gmail.com

;; This file is not part of GNU Emacs.

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; Support the standard input header argument `:stdin <element-name>`
;; for Org Babel code blocks in C/C++/D.

;;; Code:

(defun org-babel-C-execute/filter-args (args)
  (when-let* ((params (cadr args))
              (stdin (cdr (assoc :stdin params)))
              (res (org-babel-ref-resolve stdin))
              (stdin (org-babel-temp-file "c-stdin-")))
		(with-temp-file stdin (insert res))
    (let* ((cmdline (assoc :cmdline params))
           (cmdline-val (or (cdr cmdline) "")))
      (when cmdline (setq params (delq cmdline params)))
      (setq params
            (cons (cons :cmdline (concat cmdline-val " <" stdin))
                  params))
      (setf (cadr args) params)))
  args)

(with-eval-after-load 'ob-C
  (advice-add 'org-babel-C-execute :filter-args
              #'org-babel-C-execute/filter-args))

(provide 'ob-C-stdin)

;;; ob-C-stdin.el ends here
