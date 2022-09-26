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

;Selector pixeles
;Descrición: Función que obtiene los pixeles de una imagen
;Entradas: image
;Salida: list
(define (getPixeles image)
  (car (cddr image))
  )


(define (get-fila image n)
  (obtener-elementos (caddr image) (* n (car image)) (car image))
  )

;EJEMPLO DE LLAMADO: (get-fila (image 2 2 (pixbit-d  0 0 1 10) (pixbit-d  0 1 0 20) (pixbit-d 1 0 0 30) (pixbit-d 1 1 1 4)) 0)


;-------MODIFICADORES-------

;Modificador de ancho
;Descripción: Función que modifica el ancho de una imagen
;Entradas: image, int
;Salida: image
(define (setAncho image nuevoAncho)
  (image nuevoAncho (car(cdr image)) (car(cddr image)))
  )


;Modificador de alto
;Descripción: Función que modifica el alto de una imagen
;Entradas: image, int
;Salida: image
(define (setAlto image nuevoAlto)
  (image (car image) nuevoAlto (car(cddr image)))
  )



;Invertir horizontalmente
;Descripción: Función que invierte una imagen horizontalmente
;Entradas: image
;Salida: image
(define (flipH image)
  (define (flipH-iter image newImage counter)
    (if (eq? counter (car(cdr image)))
        newImage
        (flipH-iter image (append newImage (reverse (get-fila image counter))) (+ counter 1))
        )
    )
  (flipH-iter image '() 0)
)

;Invertir verticalmente
;Descripción: Función que invierte una imagen verticalmente
;Entradas: image
;Salida: image
(define (flipV image)
  (reverse (flipH image))
)







;-------OTROS-------


;Obtener elementos de una lista.
;Descripción: Función que obtiene N elementos desde una posición inicial.
;Entradas: Lista, Posición inicial, Número de elementos
;Salida: Lista con los elementos solicitados
;Tipo de recursión: Recursión de cola.
(define (obtener-elementos lista posicion cantidad)
  (if (null? lista) ;condicional
      ;#t
      (list)
      ;#f
      (if (<= posicion 0)
          (if (<= cantidad 0)
              (list)
              (cons (car lista) (obtener-elementos (cdr lista) (- posicion 1) (- cantidad 1)))
              )
          (obtener-elementos (cdr lista) (- posicion 1) cantidad)
          )
      )
  )







#|
(display "IMG1:\n")
(define img1
  (image 2 3 (pixbit-d 0 0 1 10) (pixbit-d 0 0 1 20)
         (pixbit-d 0 0 1 30) (pixbit-d 0 0 1 40)
         (pixbit-d 0 0 1 50) (pixbit-d 0 0 1 60))
  )
img1


(display "IMG1 FLIPEADO:\n")

(flipH img1)

(display "IMG1 FLIPEADO VERTICALMENTE:\n")

(flipV img1)
|#


(require "TDA_Pixbit.rkt")
(require "TDA_Pixrgb.rkt")
(require "TDA_Pixhex.rkt")
(provide (all-defined-out))