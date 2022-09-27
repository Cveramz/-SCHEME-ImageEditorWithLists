#lang scheme

;-------CONSTRUCTORES-------


;Constructor pixbit-d
;Descripción: Pixel de bit.
;Entradas: x (int), y (int), bit([0|1]), depth (int)
;Salida: pixrgb

(define (pixbit-d x y bit depth)
  (list x y bit depth))

;-------PERTENENCIA-------


;Pertenencia pixel bit
;Descripción: Función que permite determinar si es un pixel tipo bit
;Entradas: list
;Salida: boolean

(define (bit? data)
  (if (and (not(null? data)) (eq? (length data) 4) )
      ;#t
      (if (number? (car data)) ;X puede ser cualquier numero
          (if (number? (car(cdr data))) ; Y puede ser cualquier numero
              (if (or (eq? (car (cddr data)) 0) (eq? (car (cddr data)) 1) )
                  (if (number? (car (cdddr data)))
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