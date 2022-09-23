#lang scheme

;-------CONSTRUCTORES-------


;Constructor pixrgb-d
;Descripción: Pixel rgb
;Entradas: x (int), y (int), r (C), g (C), b (C), d (int)
;Observaciones de entrada: C equivale a valores entre 0 y 255.
;Salida: pixrgb

(define (pixrgb-d x y r g b d)
  (list x y r g b d))


;-------PERTENENCIA-------

;Pertenencia pixel rgb
;Descripción: Función que permite determinar si es un pixel de tipo rgb
;Entradas: list
;Salida: boolean

(define (rgb? data)
  (if (and (not(null? data)) (eq? (length data) 6) ) ; es nulo? y es de tamaño 6?
      ;#t
      (if (number? (car data)) ;X puede ser cualquier numero
          (if (number? (car(cdr data))) ; Y puede ser cualquier numero
              (if (and (< -1 (car(cddr data))) (> 256 (car(cddr data)) )) ;r
                  (if (and (< -1 (car(cdddr data))) (> 256 (car(cdddr data)) )) ;g
                      (if (and (< -1 (car(cddddr data))) (> 256 (car(cddddr data))));b
                          (if (number? (car(cdr(cddddr data))))
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
          #f
          )
      #f
      )
  )




;-------SELECTORES-------


;-------MODIFICADORES-------






;-------OTROS-------


(provide (all-defined-out))