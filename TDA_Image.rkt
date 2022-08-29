#lang scheme

#|
(define vacio empty)

(define (append dato lista)
  (cons dato lista))
|#

;Constructor bitmap

(define (bitmap largo ancho lista)
  (list largo ancho lista))