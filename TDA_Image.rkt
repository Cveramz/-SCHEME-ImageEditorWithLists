#lang scheme


;-------CONSTRUCTORES-------


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



;Pertenencia bitmap
;Descripción: Función que permite determinar si la imagen es un bitmap-d
;Entradas: image
;Salida: boolean


(define (bitmap? image)
  (if (and (number?(car image)) (number?(car(cdr image))))
      (if (eq? (length (car(cddr image))) (length (filter bit? (car(cddr image)))))
          #t
          #f
          )
      ;(filter bit? (car(cddr image)))
      #f
      )
  )

;Pertenencia pixmap (Conformado por pixeles RGB)
;Descripción: Función que permite determinar si la imagen es un bitrgb-d
;Entradas: image
;Salida: boolean
(define (pixmap? image)
  (if (and (number?(car image)) (number?(car(cdr image))))
      (if (eq? (length (car(cddr image))) (length (filter rgb? (car(cddr image)))))
          #t
          #f
          )
      #f
      )
  )

;Pertenencia hexmap
;Descripción: Función que permite determinar si la imagen es un hexmap-d
;Entradas: image
;Salida: boolean
(define (hexmap? image)
  (if (and (number?(car image)) (number?(car(cdr image))))
      (if (eq? (length (car(cddr image))) (length (filter hex? (car(cddr image)))))
          #t
          #f
          )
      #f
      )
  )




;-------SELECTORES-------



;Selector ancho
;Descrición: Función que obtiene el ancho de una imagen
;Entradas: image
;Salida: int
(define (getAncho image)
  (car image)
  )


;Selector alto
;Descrición: Función que obtiene el alto de una imagen
;Entradas: image
;Salida: int
(define (getAlto image)
  (car (cdr image))
  )





;-------MODIFICADORES-------






;-------OTROS-------

;Función que elimina los n primeros elementos de una lista
;Entradas: n (int), lista (lista)
;Salida: lista

(define (elimina-n lista n)
  (if (eq? n 0)
      lista
      (elimina-n (cdr lista) (- n 1))
      )
  )


;Función que elimina los n ultimos elementos de una lista
;Entradas: n (int), lista (lista)
;Salida: lista

(define (elimina-n-ult lista n)
  (if (eq? n 0)
      lista
      (elimina-n-ult (reverse (cdr (reverse lista))) (- n 1))
      )
  )

