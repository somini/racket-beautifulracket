#!/usr/bin/env racket
#lang br
(define (read-syntax src-path src-port)
  #| Read the whole port[file] as a string list |#
  (define src-strs (port->lines src-port))
  #| Define a function to transform each line into (dispatch "line") |#
  (define (make-datum str) (format-datum '(dispatch ~a) str))
  #| Map the function to the string list |#
  (define src-exprs (map make-datum src-strs))
  #| src-exprs now contains a list of target expressions |#

  #| Inject those expressions into the module "stacker-reader" |#
  (inject-syntax ([#'(src-expr ...) src-exprs])
                 #'(module stacker-reader br
                     src-expr ...))
  )
#| Public Functions |#
(provide read-syntax)
