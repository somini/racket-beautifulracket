#!/usr/bin/env racket
#lang br
#| The reader |#
(define (read-syntax src-path src-port)
  #| Read the whole port[file] as a string list |#
  (define src-strs (port->lines src-port))
  #| Define a function to transform each line into (dispatch "line") |#
  (define (make-datum str) (format-datum '(dispatch ~a) str))
  #| Map the function to the string list |#
  (define src-exprs (map make-datum src-strs))
  #| src-exprs now contains a list of target expressions |#

  #| Inject those expressions into the module "stacker-reader" |#
  #| Using this file as expander |#
  (inject-syntax ([#'(src-expr ...) src-exprs])
                 #'(module stacker-reader "stacker-lang.rkt"
                     src-expr ...))
  )
#| The expander |#
(define #'(stacker-module-begin reader-line ...)
  #'(#%module-begin
     reader-line ...))

#| Public Functions |#
(provide read-syntax) #| The reader |#
(provide (rename-out [stacker-module-begin #%module-begin])) #| The expander |#
