#lang scheme


;-------CONSTRUCTORES-------


;Constructor imagen
;Descripción: Función constructora de imagenes, la cual puede ser
;bitmap, hexmap o pixmap.
;Entradas: Width (int), Height (int), Información pixeles (lista o listas)
;Salida imagen

(define (image Width Height . InfPixs)
  (list Width Height InfPixs))

(define (imageWithListPix Width Height ListPixels)
  (list Width Height ListPixels))

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
  ;x1 y1 son las coordenadas del pixel inferior izquierdo
  ;x2 y2 son las coordenadas del pixel superior derecho
  ;osea, x1 es xMin, y1 es yMin, x2 es xMax, y2 es yMax
  ;utilizaremos como filter la funcion pixelEnRango(pixel, xMin, xMax, yMin, yMax) que se importa
  ;de el archivo tda_pixeles
  (filter (lambda (pixel) (pixelEnRango pixel x1 x2 y1 y2)) (getPixeles image))
  )


;Transformar imagen RGB a Hex
;Descripción: Función que transforma una imagen RGB a Hex
;Entradas: image
;Salida: image

;Primero hagamos el listado de los colores en hexadecimal
(define conversion-digitos (list "0" "1" "2" "3" "4" "5" "6" "7" "8" "9"
                                "a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k"
                "l" "m" "n" "o" "p" "q" "r" "s" "t" "u" "v"
                "w" "x" "y" "z"))


;Ahora veremos lo de las divisiones
;Primero dividimos por 16 para obtener el primer digito

(define (resultadoDivision valor) (quotient valor 16))

;Ahora obtenemos el resto de la division
(define (resultadoResto valor) (remainder valor 16))

;Ahora haremos la conversion de los colores
(define (conversionColor color)
  (string-append (list-ref conversion-digitos (resultadoDivision color))
                 (list-ref conversion-digitos (resultadoResto color)))
  )

;Ahora haremos la conversion de los pixeles
;EJEMPLO DE RGB: (pixrgb-d 1 1 40 40 40 40)
(define (conversionPixel pixel)
  (string-append (conversionColor (car (cddr pixel)))
                 (conversionColor (car (cddr (cdr pixel))))
                 (conversionColor (car (cddr (cddr pixel))))
                 )
  )

;Ahora haremos la conversion de la imagen
(define (conversionImagen image)
  (map conversionPixel (getPixeles image))
  )

;Ahora finalmente crearemos la nueva imagen

(define (imgRGB->imgHex image)
  (imageWithListPix (getAncho image) (getAlto image) (conversionImagen image))
  )



;Funcion de Histograma
;Descripción: Función que crea un histograma a partir de una imagen
;Entradas: image
;Salida: list
;===============================================================
(define (histogram image)
  ;Para el histograma debemos considerar solamente los colores de los pixeles
  ;Por lo tanto primero debemos identificar los tipos de pixeles utilizando if
  ;Luego debemos contar la cantidad de pixeles de cada tipo
  ;Finalmente debemos crear una lista con los pixeles y sus cantidades

  ;Primero identificamos el tipo de imagen, usando bitmap?, pixmap? y hexmap?

  (if (bitmap? image)
      (histogramaBitmap image)
      (if (pixmap? image)
          (histogramaPixmap image)
          (histogramaHexmap image)
          )
      )
  )

(define (histogramaBitmap image)
  ;Para el histograma de bitmap, debemos contar la cantidad de pixeles de cada color
  ;Para esto debemos crear una lista con los colores de los pixeles
  ;Luego debemos contar la cantidad de pixeles de cada color
  ;Finalmente debemos crear una lista con los pixeles y sus cantidades

  ;Primero creamos la lista de colores
  (define (listaColores image)
    (map (lambda (pixel) (car (cddr pixel))) (getPixeles image))
    )

  ;Ahora contamos la cantidad de pixeles de cada color
  (define (contarColores listaColores)
    (define (contarColores-interno listaColores listaContador)
      (if (null? listaColores)
          listaContador
          (contarColores-interno (cdr listaColores) (append listaContador (list (contarColor (car listaColores) listaColores))))
          )
      )
    (contarColores-interno listaColores '())
    )

  ;Ahora creamos la lista con los pixeles y sus cantidades
  (define (listaPixeles listaColores listaContador)
    (define (listaPixeles-interno listaColores listaContador listaPixeles)
      (if (null? listaColores)
          listaPixeles
          (listaPixeles-interno (cdr listaColores) (cdr listaContador) (append listaPixeles (list (list (car listaColores) (car listaContador)))))
          )
      )
    (listaPixeles-interno listaColores listaContador '())
    )

  ;Ahora creamos la lista con los pixeles y sus cantidades
  (listaPixeles (listaColores image) (contarColores (listaColores image)))
  )

(define (contarColor color listaColores)
  (define (contarColor-interno color listaColores contador)
    (if (null? listaColores)
        contador
        (if (equal? color (car listaColores))
            (contarColor-interno color (cdr listaColores) (+ contador 1))
            (contarColor-interno color (cdr listaColores) contador)
            )
        )
    )
  (contarColor-interno color listaColores 0)
  )

(define (histogramaPixmap image)
  ;Para el histograma de pixmap, debemos contar la cantidad de pixeles de cada color
  ;Para esto debemos crear una lista con los colores de los pixeles
  ;Luego debemos contar la cantidad de pixeles de cada color
  ;Finalmente debemos crear una lista con los pixeles y sus cantidades

  ;Primero creamos la lista de colores
  (define (listaColores image)
    (map (lambda (pixel) (car (cddr pixel))) (getPixeles image))
    )

  ;Ahora contamos la cantidad de pixeles de cada color
  (define (contarColores listaColores)
    (define (contarColores-interno listaColores listaContador)
      (if (null? listaColores)
          listaContador
          (contarColores-interno (cdr listaColores) (append listaContador (list (contarColor (car listaColores) listaColores))))
          )
      )
    (contarColores-interno listaColores '())
    )

  ;Ahora creamos la lista con los pixeles y sus cantidades
  (define (listaPixeles listaColores listaContador)
    (define (listaPixeles-interno listaColores listaContador listaPixeles)
      (if (null? listaColores)
          listaPixeles
          (listaPixeles-interno (cdr listaColores) (cdr listaContador) (append listaPixeles (list (list (car listaColores) (car listaContador)))))
          )
      )
    (listaPixeles-interno listaColores listaContador '())
    )

  ;Ahora creamos la lista con los pixeles y sus cantidades
  (listaPixeles (listaColores image) (contarColores (listaColores image)))
  )

(define (histogramaHexmap image)
  ;Para el histograma de hexmap, debemos contar la cantidad de pixeles de cada color
  ;Para esto debemos crear una lista con los colores de los pixeles
  ;Luego debemos contar la cantidad de pixeles de cada color
  ;Finalmente debemos crear una lista con los pixeles y sus cantidades

  ;Primero creamos la lista de colores
  (define (listaColores image)
    (map (lambda (pixel) (car (cddr pixel))) (getPixeles image))
    )

  ;Ahora contamos la cantidad de pixeles de cada color
  (define (contarColores listaColores)
    (define (contarColores-interno listaColores listaContador)
      (if (null? listaColores)
          listaContador
          (contarColores-interno (cdr listaColores) (append listaContador (list (contarColor (car listaColores) listaColores))))
          )
      )
    (contarColores-interno listaColores '())
    )

  ;Ahora creamos la lista con los pixeles y sus cantidades
  (define (listaPixeles listaColores listaContador)
    (define (listaPixeles-interno listaColores listaContador listaPixeles)
      (if (null? listaColores)
          listaPixeles
          (listaPixeles-interno (cdr listaColores) (cdr listaContador) (append listaPixeles (list (list (car listaColores) (car listaContador)))))
          )
      )
    (listaPixeles-interno listaColores listaContador '())
    )

  ;Ahora creamos la lista con los pixeles y sus cantidades
  (listaPixeles (listaColores image) (contarColores (listaColores image)))
  )
;===============================================================

;Funcion Rotate90
;Descripción: Función que rota una imagen 90 grados en sentido horario.
;Entradas: Imagen
;Salida: Imagen rotada 90 grados en sentido horario.
;Estrategia: Aplicar la formula -Y,X a cada pixel de la imagen.


(define (aplicarFormula pixel)
  (cons (- 0 (car(cdr pixel)))
    (cons (car pixel) (cddr pixel)))
  )


;Ahora para el rotate90, usamos la funcion map para aplicar la formula a cada pixel
(define (rotate90 image)
  (map (lambda (pixel) (aplicarFormula pixel)) (getPixeles image))
  )
;===============================================================

;Funcion que edita imagen.
;Descripcion: Funcion que aplica funciones especiales a imagenes.
;Entrada: Funcion, Imagen
;Salida: Imagen

(define (edit funct image)
  (map (lambda (pixel) (funct pixel)) (getPixeles image)))


;===============================================================

;Funcion que invierte el bit
;Descripcion: Funcion que invierte el bit a pixel, este en conjunto con edit lo cambia a todos.
;Entrada: Pixel
;Salida: Pixel

(define (invertColorBit pixel)
  (if (= (car (cddr pixel)) 0)
      (cons (car pixel) (cons (car (cdr pixel)) (cons 1(cons (car(cdddr pixel)) '()))))
      (cons (car pixel) (cons (car (cdr pixel)) (cons 0(cons (car(cdddr pixel)) '()))))))




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








(require "TDA_Pixbit_20816739_VeraRamirez.rkt")
(require "TDA_Pixrgb_20816739_VeraRamirez.rkt")
(require "TDA_Pixhex_20816739_VeraRamirez.rkt")
(require "TDA_Pixeles_20816739_VeraRamirez.rkt")
(provide (all-defined-out))