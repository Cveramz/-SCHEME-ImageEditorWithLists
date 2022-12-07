#lang scheme

;-------CONSTRUCTORES-------

;-------PERTENENCIA-------

(define (pixelEnRango pixel xMin xMax yMin yMax)
  (and (>= (getX pixel) xMin)
       (<= (getX pixel) xMax)
       (>= (getY pixel) yMin)
       (<= (getY pixel) yMax))
  )

;-------SELECTORES-------

(define (getX pixel)
  (car pixel))

(define (getY pixel)
  (car (cdr pixel)))

;-------MODIFICADORES-------

(define (setX pixel x)
  (cons x (cdr pixel)))

;setY, cambia el segundo elemento de la lista

(define (setY pixel y)
  (cons (car pixel) (cons y (cdr (cdr pixel)))))



;-------OTROS-------


(provide (all-defined-out))