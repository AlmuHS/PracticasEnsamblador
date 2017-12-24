;Copyright 2015 Almudena Garcia Jurado-Centurion

;This file is part of practica1.

;practica1 is free software: you can redistribute it and/or modify
;it under the terms of the GNU General Public License as published by
;the Free Software Foundation, either version 3 of the License, or
;(at your option) any later version.

;practica1 is distributed in the hope that it will be useful,
;but WITHOUT ANY WARRANTY; without even the implied warranty of
;MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;GNU General Public License for more details.

;You should have received a copy of the GNU General Public License
;along with practica1.  If not, see <http://www.gnu.org/licenses/>.


.MODEL SMALL

.DATA

	TABLA_A DB 10, 5, 1
	TABLA_B DB 0, 0, 0
	
.CODE

	MOV AX, SEG TABLA_B ;Copiamos en AX la direccion de memoria de la tabla B
	MOV DS, AX ;Inicializamos el registro DS con el contenido de AX
	
	MOV SI, 0
	
	BUCLE:
		MOV AL, TABLA_A[SI]
		MOV TABLA_B[SI], AL
		
		INC SI
		CMP SI, 2
	JBE BUCLE; Cuando SI > 2, termina
	
	
	MOV AH, 4Ch
	INT 21h
	
END
