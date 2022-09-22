#lang scheme

;Constructor pixbit-d
;Descripción: Pixel de bit.
;Entradas: x (int), y (int), bit([0|1]), depth (int)
;Salida: pixrgb

(define (pixbit-d x y bit depth)
  (list x y bit depth))