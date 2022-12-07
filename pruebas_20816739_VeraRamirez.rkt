#lang scheme

(require "TDA_Image_20816739_VeraRamirez.rkt")
(require "TDA_Pixbit_20816739_VeraRamirez.rkt")
(require "TDA_Pixrgb_20816739_VeraRamirez.rkt")
(require "TDA_Pixhex_20816739_VeraRamirez.rkt")

;===============MIS PRUEBAS===============
(display "============MIS PRUEBAS============\n")

;Constructor de imagenes:

;Pixbit
(define mi-img1
  (image 2 2 (pixbit-d  0 0 1 10) (pixbit-d  0 1 0 20) (pixbit-d 1 0 0 30) (pixbit-d 1 1 1 4))
  )

;Pixrgb

(define mi-img2
(image 2 2 (pixrgb-d  0 0 10 10 10 10) (pixrgb-d  0 1 20 20 20 20) (pixrgb-d 1 0 30 30 30 30) (pixrgb-d 1 1 40 40 40 40))
  )

;Pixhex
(define mi-img3
(image 2 2 (pixhex-d 0 0 "FF2D00" 0) (pixhex-d 0 0 "ECFF00" 0) (pixhex-d 0 0 "36FF00" 0) (pixhex-d 0 0 "25A1C6" 0))
  )

(define mi-img4
  (image 5 1 (pixbit-d  0 0 1 10) (pixbit-d  0 0 1 20) (pixbit-d  0 0 1 30))
  )


(define mi-img5
  (image 3 3 (pixbit-d  0 0 1 10) (pixbit-d  0 1 0 20) (pixbit-d 1 0 0 30) (pixbit-d 1 1 1 4) (pixbit-d 1 2 1 4) (pixbit-d 2 0 1 4) (pixbit-d 2 1 1 4) (pixbit-d 2 2 1 4) (pixbit-d 3 0 1 5))
  )

(display "imagen1 (Pixbit):\n")
mi-img1
(display "imagen2 (Pixrgb):\n")
mi-img2
(display "imagen3 (Pixhex):\n")
mi-img3
(display "imagen4 (Pixhex, comprimido):\n")
mi-img4
(display "imagen5 (Pixbit 3x3):\n")
mi-img5



;Pertenencia bitmap
(display "Pertenencia bitmap:\n")

(bitmap? mi-img1) ;#t
(bitmap? mi-img2) ;#f
(bitmap? mi-img3) ;#f


;Pertenencia pixmap
(display "Pertenencia pixmap:\n")

(pixmap? mi-img1) ;#f
(pixmap? mi-img2) ;#t
(pixmap? mi-img3) ;#f

;Pertenencia hexmap
(display "Pertenencia hexmap:\n")

(hexmap? mi-img1) ;#f
(hexmap? mi-img2) ;#f
(hexmap? mi-img3) ;#t


;Pertenencia comprimido
(display "Pertenencia comprimido (compressed?):\n")
(display "Ej mi-img1\n")
(compressed? mi-img1)
(display "Ej mi-img2\n")
(compressed? mi-img2)
(display "Ej mi-img4\n")
(compressed? mi-img4)

;Modificador invertidor horizontalmente
(display "Modificador invertidor horizontalmente:\n")
(display "Ej mi-img1\n")
(flipH mi-img1)
(display "Ej mi-img2\n")
(flipH mi-img2)
(display "Ej mi-img4\n")
(flipH mi-img4)


;Modificador invertidor verticalmente
(display "Modificador invertidor verticalmente:\n")
(display "Ej mi-img1\n")
(flipV mi-img1)
(display "Ej mi-img2\n")
(flipV mi-img2)
(display "Ej mi-img4\n")
(flipV mi-img4)

;Modificador recortar imagen
(display "Modificador recortar imagen:\n")
(display "Ej mi-img1\n")
(crop mi-img1 0 0 0 1)
(display "Ej mi-img2\n")
(crop mi-img2 0 0 1 1)
(display "Ej mi-img5\n")
(crop mi-img5 0 0 3 1)


;===============PRUEBAS ENUNCIADO===============
(display "\n============PRUEBAS ENUNCIADO============\n")


(define img1 (image 2 2
                  (pixrgb-d 0 0 255 0 0 10)
                  (pixrgb-d 0 1 0 255 0 20)
                  (pixrgb-d 1 0 0 0 255 10)
                  (pixrgb-d 1 1 255 255 255  1))
 )

(define img2 (image 2 2
                  (pixbit-d 0 0 0 10)
                  (pixbit-d 0 1 1 20)
                  (pixbit-d 1 0 1 10)
                  (pixbit-d 1 1 0 255))
 )

;(define img3 (imgRGB->imgHex img1))

;(display (image->string img1 pixrgb->string)

;(display (image->string img2 pixbit->string)

(bitmap? img1) ; la respuesta debería ser #f
(bitmap? img2)  ; la respuesta debería ser #t
;(bitmap? img3)  ; la respuesta debería ser #f

(pixmap? img1) ; la respuesta debería ser #t
(pixmap? img2)  ; la respuesta debería ser #f
;(pixmap? img3)  ; la respuesta debería ser #f

(hexmap? img1) ; la respuesta debería ser #f
(hexmap? img2)  ; la respuesta debería ser #f
;(hexmap? img3)  ; la respuesta debería ser #t

(compressed? img1) ; la respuesta debería ser #f
(compressed? img2) ; la respuesta debería ser #f
;(compressed? img3) ; la respuesta debería ser #f

(flipH img1)
(flipH img2)
;(flipH img3)

(flipV img1)
(flipV img2)
;(flipV img3)

(define img4 (crop img1 0 0 0 0)) ; debería retornar una imágen con un pixel
(define img5 (crop img2 0 0 0 1)) ; debería retornar una imágen con dos pixeles
(define img6 (crop img1 0 1 1 1)) ; debería retornar una imágen con dos pixeles
(define img7 (crop img2 0 0 1 1)) ; debería retornar la misma imagen

;(histogram img1)
;(histogram img2)

;(histogram img3)
;(histogram img4)
;(histogram img5)
;(histogram img6)
;(histogram img7)

(define img18 (rotate90 img1))
(define img19 (rotate90 img2))
;(define img20 (rotate90 img3))
;(define img21 (rotate90 img4))
;(define img22 (rotate90 img5))
;(define img23 (rotate90 img6))
;(define img24 (rotate90 img7))

;(define img8 (compress img1))
;(define img9 (compress img2))
;(define img10 (compress img3))
;(define img11 (compress img4))
;(define img12 (compress img5))
;(define img13 (compress img6))
;(define img14 (compress img7))

;(compressed? img8)  ; la respuesta debería ser #t
;(compressed? img9)  ; la respuesta debería ser #t
;(compressed? img10)  ; la respuesta debería ser #t
;(compressed? img11)  ; la respuesta debería ser #t
;(compressed? img12)  ; la respuesta debería ser #t
;(compressed? img13)  ; la respuesta debería ser #t
;(compressed? img14)  ; la respuesta debería ser #t

;(define img15 (edit invertColorBit img2))
;(define img16 (edit invertColorRGB img1))

;se asume que las funciones de ajuste de canal están implementadas. 
;Puede cambiarlas por otras en su script de pruebas si así lo prefiere 
;(define img33 (edit (adjustChannel getR setR incCh) img1))
;(define img34 (edit (adjustChannel getG setG incCh) img1))
;(define img35 (edit (adjustChannel getB setB incCh) img1))

;(display (image->string img1 pixrgb->string))
;(display (image->string img2 pixbit->string))
;(display (image->string img3 pixhex->string))
;(display (image->string img4 pixrgb->string))
;(display (image->string img5 pixbit->string))
;(display (image->string img6 pixrgb->string))
;(display (image->string img7 pixrbit->string))

;imagenes comprimidas, podrían internamente descomprimirlas para convertir a string 
;(display (image->string img8 pixrgb->string))
;(display (image->string img9 pixbit->string))
;(display (image->string img10 pixhex->string)) 
;(display (image->string img11 pixrgb->string))
;(display  (image->string img12 pixbit->string))
;(display (image->string img13 pixrgb->string))
;(display (image->string img14 pixbit->string))

;imágenes no comprimidas
;(display (image->string img15 pixrgb->string))
;(display (image->string img16 pixrgb->string))
;(display (image->string img17 pixrgb->string))
;(display (image->string img18 pixrgb->string))
;(display (image->string img19 pixbit->string))
;(display (image->string img20 pixhex->string))
;(display (image->string img21 pixrgb->string))
;(display (image->string img22 pixbit->string))
;(display (image->string img23 pixrgb->string))
;(display (image->string img24 pixbit->string))

;(depthLayers img1)
;(depthLayers img2)
;(depthLayers img3)
;(depthLayers img4)
;(depthLayers img5)
;(depthLayers img6)
;(depthLayers img7)

;(define img25 (decompress img8))
;(define img26 (decompress img9))
;(define img27 (decompress img10))
;(define img28 (decompress img11))
;(define img29 (decompress img12))
;(define img30 (decompress img13))
;(define img31 (decompress img14))

;las siguientes comparaciones deberían arrojar #t
;(equal? img25 img1)
;(equal? img26 img2)
;(equal? img27 img3)
;(equal? img28 img4)
;(equal? img29 img5)
;(equal? img30 img6)
;(equal? img31 img7)

;las siguientes comparaciones deberían arrojar #f
;(equal? img25 img2)
;(equal? img26 img1)
