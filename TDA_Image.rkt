#lang scheme


;-------CONSTRUCTORES-------

;Constructor pixbit-d
;Descripción: Pixel de bit.
;Entradas: x (int), y (int), bit([0|1]), depth (int)
;Salida: pixrgb

(define (pixbit-d x y bit depth)
  (list x y bit depth))

;Constructor pixrgb-d
;Descripción: Pixel rgb
;Entradas: x (int), y (int), r (C), g (C), b (C), d (int)
;Observaciones de entrada: C equivale a valores entre 0 y 255.
;Salida: pixrgb

(define (pixrgb-d x y r g b d)
  (list x y r g b d))

;Constructor pixhex
;Entradas: x (int), y (int), hex (String), d (int)
;Salida: pixhex

(define (pixhex-d x y hex d)
  (list x y hex d))


;Constructor imagen
;Descripción: Función constructora de imagenes, la cual puede ser
;bitmap, hexmap o pixmap.
;Entradas: Width (int), Height (int), Información pixeles (lista o listas)
;Salida imagen

(define (image Width Height . InfPixs)
  (list Width Height InfPixs))


;-------PERTENENCIA-------




;Pertenencia pixel bit
;Descripción: Función que permite determinar si es un pixel tipo bit
;Entradas: list
;Salida: boolean

(define (bit? data)
  (if (not(null? data))
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


;Pertenencia pixel rgb
;Descripción: Función que permite determinar si es un pixel de tipo rgb
;Entradas: list
;Salida: boolean

(define (rgb? data)
  (if (not(null? data))
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




;Pertenencia pixel hex
;Descripción: Función que permite determinar si es un pixel de tipo hex
;Entradas: list
;Salida: boolean

(define (hex? data)
  (if (not(null? data))
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



;Pertenencia bitmap
;Descripción: Función que permite determinar si la imagen es un bitmap-d
;Entradas: image
;Salida: boolean