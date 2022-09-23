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


;Compressed?
;Descripción: Función que determina si una imagen está comprimida.
;Entrada: Image
;Salida: Boolean

(define (compressed? image)
  (if (not
       (eq?
        (* (car image) (car(cdr image))) (length (car(cddr image)))
        ))
      #t
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



(require "TDA_Pixbit.rkt")
(require "TDA_Pixhex.rkt")
(require "TDA_Pixrgb.rkt")
(provide (all-defined-out))