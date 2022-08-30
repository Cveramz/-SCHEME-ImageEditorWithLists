#lang scheme

#|Estructuras Base del TDA:
-image
-pixbit-d
-pixrgb-d
-pixhex-d|#



;-------CONSTRUCTORES-------

;Constructor pixbit-d
;Entradas: x (int), y (int), bit([0|1]), depth (int)
;Salida: Lista

(define (pixbit-d x y bit depth)
  (list x y bit depth))

;Constructor pixrg-d
;Entradas: x (int), y (int), r (C), g (C), b (C), d (int)
;Observaciones de entrada: C equivale a valores entre 0 y 255.
;Salida: Lista

(define (pixrg-d x y r g b d)
  (list x y r g b d))

;Constructor pixhex
;Entradas: x (int), y (int), hex (String), d (int)
;Salida: List

(define (pixrgb x y hex d)
  (list x y hex d))


;Constructor imagen
;Descripción: Función constructora de imagenes, la cual puede ser
;bitmap, hexmap o pixmap.
;Entradas: Width (int), Height (int), Variacion (function)
;Salida: image

#|(define (image Width Height Variacion)
  )

|#