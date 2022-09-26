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
  (define (flipH-interno image newImage counter)
    (if (eq? counter (car(cdr image)))
        newImage
        (flipH-interno image (append newImage (reverse (get-fila image counter))) (+ counter 1))
        )
    )
  (flipH-interno image '() 0)
)

;Invertir verticalmente
;Descripción: Función que invierte una imagen verticalmente
;Entradas: image
;Salida: image
(define (flipV image)
  (reverse (flipH image))
)

;Recortar imagen
;Descripción: Función que recorta una imagen
;Entradas: image, int, int, int, int
;Salida: image

(define (crop image x1 y1 x2 y2)
  ;x1 y1 son las coordenadas del pixel superior izquierdo
  ;x2 y2 son las coordenadas del pixel inferior derecho
  ;en caso que x1,y2,x2,y2 sean iguales se retorna solo un pixel
  (define (crop-interno image newImage counter)
    (if (eq? counter (car(cdr image)))
        newImage
        (if (and (>= counter y1) (<= counter y2))
            (crop-interno image (append newImage (obtener-elementos (get-fila image counter) x1 (- x2 x1))) (+ counter 1))
            (crop-interno image newImage (+ counter 1))
            )
        )
    )
  (crop-interno image '() 0)
  )
  

;Rotar imagen 90 grados
;Descripción: rota la imágen 90° a la derecha. 
;Entradas: image
;Salida: image

(define (rotate90 image)
  (define (rotate90-interno image newImage counter)
    (if (eq? counter (car image))
        newImage
        (rotate90-interno image (append newImage (reverse (obtener-elementos (getPixeles image) counter (car(cdr image))))) (+ counter 1))
        )
    )
  (rotate90-interno image '() 0)
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








(require "TDA_Pixbit_20816739-1_VeraRamirez.rkt")
(require "TDA_Pixrgb_20816739-1_VeraRamirez.rkt")
(require "TDA_Pixhex_20816739-1_VeraRamirez.rkt")
(provide (all-defined-out))