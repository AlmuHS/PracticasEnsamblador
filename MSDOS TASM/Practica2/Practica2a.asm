;Copyright 2015 Almudena Garcia Jurado-Centurion

;This file is part of practica2.

;practica2 is free software: you can redistribute it and/or modify
;it under the terms of the GNU General Public License as published by
;the Free Software Foundation, either version 3 of the License, or
;(at your option) any later version.

;practica2 is distributed in the hope that it will be useful,
;but WITHOUT ANY WARRANTY; without even the implied warranty of
;MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;GNU General Public License for more details.

;You should have received a copy of the GNU General Public License
;along with practica2.  If not, see <http://www.gnu.org/licenses/>.


.MODEL SMALL

.DATA

.CODE

	;Establecer modo pantalla
	MOV AL, 03h ;Codigo modo texto
	MOV AH, 0
	INT 10h ;Interrupcion modo texto
	
	;Memoria de video en modo texto
	MOV AX, 0B800h
	MOV ES, AX
	
FIN:
	
	;Esperamos que se pulse una tecla antes de salir
	MOV AH, 0
	INT 16h ;Interrupcion de teclado
	
	
	;Limpiar pantalla
	MOV AL, 03h
	MOV AH, 0
	INT 10h
	
	MOV AH, 4Ch
	INT 21h
	
END
