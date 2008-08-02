;; -*- mode: Lisp; -*-
(defconst epita-c-style
  '((c-tab-always-indent . t)
    (c-comment-only-line-offset . 0)
    (c-hanging-braces-alist . ((substatement-open after)
                               (brace-list-open)))
    (c-hanging-colons-alist . ((member-init-intro before)
                               (inher-intro)
                               (case-label after)
                               (label after)
                               (access-label after)))
    (c-cleanup-list . (scope-operator empty-defun-braces defun-close-semi))
    (c-basic-offset . 2)
    (c-offsets-alist . ((substatement . 2)
			(substatement-open . 0)
                        (case-label . 1)
                        (statement-case-open . 0)
                        (block-open . 2)
                        (brace-list-open . 0)
                        (inline-open . 0)
                        (statement-block-intro . 2)
                        ))
    (c-echo-syntactic-information-p . t))
  "Epita Programming Style")
(c-add-style "epita" epita-c-style)

(c-set-offset 'substatement-open 0)   ; change '{' indentation
(c-set-offset 'case-label '+)         ; make each case line indent from switch
