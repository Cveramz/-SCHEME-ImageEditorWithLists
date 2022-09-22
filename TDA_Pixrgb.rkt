#lang scheme


;Constructor pixrgb-d
;Descripción: Pixel rgb
;Entradas: x (int), y (int), r (C), g (C), b (C), d (int)
;Observaciones de entrada: C equivale a valores entre 0 y 255.
;Salida: pixrgb

(define (pixrgb-d x y r g b d)
  (list x y r g b d))
