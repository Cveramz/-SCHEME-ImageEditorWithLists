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


(define (obtener-fila image n)
  (obtener-elementos (caddr image) (* n (car image)) (car image))
  )

;EJEMPLO DE LLAMADO: (obtener-fila (image 2 2 (pixbit-d  0 0 1 10) (pixbit-d  0 1 0 20) (pixbit-d 1 0 0 30) (pixbit-d 1 1 1 4)) 0)


;-------MODIFICADORES-------





;Invertir horizontalmente
;Descripción: Función que invierte una imagen horizontalmente
;Entradas: image
;Salida: image

;Pasar de esto:
;(2 3 
;( (0 0 1 1) (0 1 1 2)
; (1 0 2 1) (1 1 2 2)
; (1 1 3 1) (1 1 3 2)) )

;A esto:

;(2 3
;(0 1 1 2) (0 0 1 1)
;(1 0 2 2) (1 1 2 1)
;(1 1 3 2) (1 1 3 1))






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

;Append a final de lista.
;Descripción: Función que agrega un elemento al final de una lista.
;Entradas: Lista, Elemento
;Salida: Lista con el elemento agregado al final
;Tipo de recursión: Recursión Natural.
(define (append-final lista elemento)
  (if (null? lista)
      (list elemento)
      (cons (car lista) (append-final (cdr lista) elemento))
      )
  )

;Agregar elementos de una lista a otra.
;Descripción: Función que agrega los elementos de una lista a otra.
;Entradas: Lista, Lista
;Salida: Lista con los elementos agregados
;Tipo de recursión: Recursión natural.
(define (agregar-elementos lista1 lista2)
  (if (null? lista1)
      lista2
      (agregar-elementos (cdr lista1) (append-final lista2 (car lista1)))
      )
  )


;Agregar fila invertida a una lista.
;Descripción: Función que agrega una fila invertida a una lista.
;Entradas: Lista posición fila -1.
;Salida: Lista con la fila invertida agregada.
(define (agregar-fila-invertida image n)
  (agregar-elementos (reverse(obtener-fila image n)) (list))
  )

(define img1
  (image 2 2 (pixbit-d 0 0 1 10) (pixbit-d 0 1 0 20) (pixbit-d 1 0 0 30) (pixbit-d 1 1 1 4))
)
;IMG1 = (2 2 (0 0 1 10) (0 1 0 20) (1 0 0 30) (1 1 1 4))
img1
(agregar-fila-invertida img1 0)

;Crear función que reciba una imagen y devuelva una lista con las filas invertidas.
;Descripción: Función que recibe una imagen y devuelve una lista con las filas invertidas.
;Entradas: ListaPixeles, largo, alto, lista.
;Salida: Lista con las filas invertidas.

;(define (invertir-filas infPixeles largo alto newList)

(require "TDA_Pixbit.rkt")
(require "TDA_Pixhex.rkt")
(require "TDA_Pixrgb.rkt")
(provide (all-defined-out))