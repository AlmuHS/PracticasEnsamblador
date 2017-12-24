;Copyright 2016 Almudena Garcia Jurado-Centurion

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


section .text
	global _start
	cpu 386
_start:
        ;Aqui va el codigo
	
	;como sólo hay un segmento de datos,
	;y el de código no se puede modificar (por cuestiones de seguridad)
	;en general serán innecesarios los prefijos de segmento en los direccionamientos
    
	MOV ESI, TABLA_A
	MOV EDI, TABLA_B
	MOV CX, 3

	BUCLE:		
		MOV AL, [ESI]
		MOV [EDI], AL
		
		INC ESI
		INC EDI
	LOOP BUCLE; Cuando CX=0, termina

	;terminar la ejecución (AX=1)
	MOV EAX,1
	INT 80h

section .data
	;Aqui los datos inicializados
	TABLA_A DB 10, 5, 1
	TABLA_B DB 0, 0, 0

