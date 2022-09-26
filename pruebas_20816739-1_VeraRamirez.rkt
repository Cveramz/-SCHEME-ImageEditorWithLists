#lang scheme

(require "TDA_Image_20816739-1_VeraRamirez.rkt")
(require "TDA_Pixbit_20816739-1_VeraRamirez.rkt")
(require "TDA_Pixrgb_20816739-1_VeraRamirez.rkt")
(require "TDA_Pixhex_20816739-1_VeraRamirez.rkt")



;Constructor de imagenes:

;Pixbit
(define img1
  (image 2 2 (pixbit-d  0 0 1 10) (pixbit-d  0 1 0 20) (pixbit-d 1 0 0 30) (pixbit-d 1 1 1 4))
  )

;Pixrgb

(define img2
(image 2 2 (pixrgb-d  0 0 10 10 10 10) (pixrgb-d  0 1 20 20 20 20) (pixrgb-d 1 0 30 30 30 30) (pixrgb-d 1 1 40 40 40 40))
  )

;Pixhex
(define img3
(image 2 2 (pixhex-d 0 0 "FF2D00" 0) (pixhex-d 0 0 "ECFF00" 0) (pixhex-d 0 0 "36FF00" 0) (pixhex-d 0 0 "25A1C6" 0))
  )

(define img4
  (image 5 1 (pixbit-d  0 0 1 10) (pixbit-d  0 0 1 20) (pixbit-d  0 0 1 30))
  )


(define img5
  (image 3 3 (pixbit-d  0 0 1 10) (pixbit-d  0 1 0 20) (pixbit-d 1 0 0 30) (pixbit-d 1 1 1 4) (pixbit-d 1 2 1 4) (pixbit-d 2 0 1 4) (pixbit-d 2 1 1 4) (pixbit-d 2 2 1 4) (pixbit-d 3 0 1 5))
  )

(display "imagen1 (Pixbit):\n")
img1
(display "imagen2 (Pixrgb):\n")
img2
(display "imagen3 (Pixhex):\n")
img3
(display "imagen4 (Pixhex, comprimido):\n")
img4
(display "imagen5 (Pixbit 3x3):\n")
img5



;Pertenencia bitmap
(display "Pertenencia bitmap:\n")

(bitmap? img1) ;#t
(bitmap? img2) ;#f
(bitmap? img3) ;#f


;Pertenencia pixmap
(display "Pertenencia pixmap:\n")

(pixmap? img1) ;#f
(pixmap? img2) ;#t
(pixmap? img3) ;#f

;Pertenencia hexmap
(display "Pertenencia hexmap:\n")

(hexmap? img1) ;#f
(hexmap? img2) ;#f
(hexmap? img3) ;#t


;Pertenencia comprimido
(display "Pertenencia comprimido (compressed?):\n")
(display "Ej img1\n")
(compressed? img1)
(display "Ej img2\n")
(compressed? img2)
(display "Ej img4\n")
(compressed? img4)

;Modificador invertidor horizontalmente
(display "Modificador invertidor horizontalmente:\n")
(display "Ej img1\n")
(flipH img1)
(display "Ej img2\n")
(flipH img2)
(display "Ej img4\n")
(flipH img4)


;Modificador invertidor verticalmente
(display "Modificador invertidor verticalmente:\n")
(display "Ej img1\n")
(flipV img1)
(display "Ej img2\n")
(flipV img2)
(display "Ej img4\n")
(flipV img4)

;Modificador recortar imagen
(display "Modificador recortar imagen:\n")
(display "Ej img1\n")
(crop img1 0 0 1 1)
(display "Ej img2\n")
(crop img2 0 0 1 1)
(display "Ej img5\n")
(crop img5 0 0 3 1)