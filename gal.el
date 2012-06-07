;;; gal.el -- ギャル文字はすぐ目の前に...
;;
;; MAHALO License (based on MIT License)
;;
;; Copyright (c) 2012 Wataru MIYAGUNI (gonngo _at_ gmail.com)
;;
;; Permission is hereby granted, free of charge, to any person obtaining a copy
;; of this software and associated documentation files (the "Software"), to deal
;; in the Software without restriction, including without limitation the rights
;; to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
;; copies of the Software, and to permit persons to whom the Software is
;; furnished to do so, subject to the following conditions:
;;
;; 1. The above copyright notice and this permission notice shall be included in
;; all copies or substantial portions of the Software.
;; 2. Shall be grateful for something (including, but not limited this software).
;;
;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
;; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
;; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
;; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
;; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
;; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
;; THE SOFTWARE.

;;; Usage:
;;
;; 1. (add-to-list 'load-path (expand-file-name "/path/to/gal-el"))
;; 2. (require 'gal-el "gal.el")
;; 3. Specify region you want to convert to gal strings.
;; 4. M-x gal:replace
;; 5. Yeah!!
;;

(require 'json)

(defvar gal:basedir (file-name-directory load-file-name))

(defun gal:replace (start end)
  (interactive "r")
  (let ((orig-str (buffer-substring-no-properties start end))
        (gal-source (json-read-file (concat gal:basedir "./gal.json")))
        gal-list gal-str)
    (setq gal-str
          (mapconcat
           #'(lambda (c)
              (setq gal-list (cdr (assoc (intern c) gal-source)))
              (if (= 0 (length gal-list)) c
                (aref gal-list (random (length gal-list)))))
           (split-string orig-str "") ""))
    (delete-region start end)
    (insert gal-str)))

(provide 'gal-el)
