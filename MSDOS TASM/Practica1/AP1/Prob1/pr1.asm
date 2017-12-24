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
	A DW 500
	B DW 400
	C DW 100

.CODE
	MOV AX, seg A ;Indicamos la posicion de memoria de A
	MOV DS, AX ;Indicamos que los datos se van a escribir en AX
	
	MOV AX, A ;movemos la variable A al registro acumulador AX
	SUB AX, B ;restamos a AX el valor de B
	SUB AX, C ;restamos a AX el valor de C
	
	MOV AH, 4ch
	INT 21h
END
