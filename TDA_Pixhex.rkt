#lang scheme

;-------CONSTRUCTORES-------


;Constructor pixhex
;Entradas: x (int), y (int), hex (String), d (int)
;Salida: pixhex

(define (pixhex-d x y hex d)
  (list x y hex d))


;-------PERTENENCIA-------


;Pertenencia pixel hex
;Descripción: Función que permite determinar si es un pixel de tipo hex
;Entradas: list
;Salida: boolean

(define (hex? data)
  (if (and (not(null? data)) (eq? (length data) 4) )
      (if (number? (car data));x
          (if (number? (car(cdr data)));y
              (if (string? (car(cddr data)));hex
                  (if (number? (car(cdddr data)))
                      #t
                      #f
                      )
                  #f
                  )
              #f
              )
          #f
          )
      #f
      )
  )


;-------SELECTORES-------


;-------MODIFICADORES-------






;-------OTROS-------


(provide (all-defined-out))