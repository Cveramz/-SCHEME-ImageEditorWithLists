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
;Recorrido: imagen

(define (image Width Height . InfPixs)
  (list Width Height InfPixs))