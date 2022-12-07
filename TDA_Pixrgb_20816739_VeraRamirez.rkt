#lang scheme

;-------CONSTRUCTORES-------


;Constructor pixrgb-d
;Descripción: Pixel rgb
;Entradas: x (int), y (int), r (C), g (C), b (C), d (int)
;Observaciones de entrada: C equivale a valores entre 0 y 255.
;Salida: pixrgb

(define (pixrgb-d x y r g b d)
  (list x y r g b d))

;-------PERTENENCIA-------

;Pertenencia pixel rgb
;Descripción: Función que permite determinar si es un pixel de tipo rgb
;Entradas: list
;Salida: boolean

(define (rgb? data)
  (if (and (not(null? data)) (eq? (length data) 6) ) ; es nulo? y es de tamaño 6?
      ;#t
      (if (number? (car data)) ;X puede ser cualquier numero
          (if (number? (car(cdr data))) ; Y puede ser cualquier numero
              (if (and (< -1 (car(cddr data))) (> 256 (car(cddr data)) )) ;r
                  (if (and (< -1 (car(cdddr data))) (> 256 (car(cdddr data)) )) ;g
                      (if (and (< -1 (car(cddddr data))) (> 256 (car(cddddr data))));b
                          (if (number? (car(cdr(cddddr data))))
                              #t
                              #f
                              )
                          #f
                          )
                      #f
                      )
                  #f
                  )
              #f
              )
          #f
          )
      #f
      )
  )




;-------SELECTORES-------


;Selector r
;Descripción: Función que permite obtener el valor de r
;Entradas: pixrgb
;Salida: int

(define (r data)
  (car(cddr data)))

;Selector g
;Descripción: Función que permite obtener el valor de g
;Entradas: pixrgb
;Salida: int

(define (g data)
  (car(cdddr data)))

;Selector b
;Descripción: Función que permite obtener el valor de b
;Entradas: pixrgb
;Salida: int

(define (b data)
  (car(cddddr data)))

;Selector d (depth)
;Descripción: Función que permite obtener el valor de depth
;Entradas: pixrgb
;Salida: int

(define (d data)
  (car(cdr(cddddr data))))

;-------MODIFICADORES-------

;Modificador x
;Descripción: Función que permite modificar el valor de x
;Entradas: pixrgb, int
;Salida: pixrgb

(define (set-x data x)
    (list x (car(cdr data)) (car(cddr data)) (car(cdddr data)) (car(cddddr data)) (car(cdr(cddddr data))))
    )

;Modificador y
;Descripción: Función que permite modificar el valor de y
;Entradas: pixrgb, int
;Salida: pixrgb

(define (set-y data y)
    (list (car data) y (car(cddr data)) (car(cdddr data)) (car(cddddr data)) (car(cdr(cddddr data))))
    )

;Modificador r
;Descripción: Función que permite modificar el valor de r
;Entradas: pixrgb, int
;Salida: pixrgb

(define (set-r data r)
    (list (car data) (car(cdr data)) r (car(cdddr data)) (car(cddddr data)) (car(cdr(cddddr data))))
    )

;Modificador g
;Descripción: Función que permite modificar el valor de g
;Entradas: pixrgb, int
;Salida: pixrgb

(define (set-g data g)
    (list (car data) (car(cdr data)) (car(cddr data)) g (car(cddddr data)) (car(cdr(cddddr data))))
    )

;Modificador b
;Descripción: Función que permite modificar el valor de b
;Entradas: pixrgb, int
;Salida: pixrgb

(define (set-b data b)
    (list (car data) (car(cdr data)) (car(cddr data)) (car(cdddr data)) b (car(cdr(cddddr data))))
    )

;Modificador d (depth)
;Descripción: Función que permite modificar el valor de depth
;Entradas: pixrgb, int
;Salida: pixrgb

(define (set-d data d)
    (list (car data) (car(cdr data)) (car(cddr data)) (car(cdddr data)) (car(cddddr data)) d)
    )

;Modificador que transforma pixrgb a pixhex
;Descripción: Transforma una imagen desde una representación RGB a una representación HEX.
;Entradas: pixrgb
;Salida: pixhex






;-------OTROS-------


(provide (all-defined-out))