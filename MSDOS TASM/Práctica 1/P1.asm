.MODEL small    ; Declaramos el modelo de 
.DATA           ; memoria

A dw 500
B dw 400        ; Declaramos los datos
C dw 100

.CODE

MOV AX, seg A   ; Indicamos al micro 
MOV DS, AX      ; donde se encuentran 
                ; los datos 

MOV AX, A       ; Realizamos la operacion 
SUB AX ,B       ; AX = A-B-C
SUB AX, C

MOV AH, 4ch
INT 21h

END