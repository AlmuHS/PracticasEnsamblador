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

.CODE
	org 100h
	Programa_Int:
		JMP Reside

		;;;;; Declaracion de variables
		CONTADOR DB 18
		MS DB '00:00$'
		

	Rutina_Servicio PROC
		CLI
		; Salvar el contenido de los registros implicados en la rutina
		PUSH DX
		PUSH AX
		PUSH EX
		PUSH CX
		PUSH SI

		;Operaciones
		CONTAR:
			DEC CONTADOR
		JZ MOSTRAR_CRONO
		JNZ SALIR
		
		MOSTRAR_CRONO:
			;Inicializar modo texto
			MOV AX, 0B8000h
			MOV ES, AX
			
			;definicion modo texto
			MOV AL, 03h
			mov AH, 0
			INT 10h
		
		JZ SUMAR_SEG
		SUMAR_SEG:
		    MOV CONTADOR, 18
		    INC MS[1]
		    CMP MS[1], 60
		JNE CONTAR
		
		JE SUMAR_MIN
		SUMAR_MIN:
		    INC MS[0]
		    MOV MS[1], 0
		JMP Programa_Int

		; Recupera el valor de los registros implicados en la rutina
		POP SI
		POP CX
		POP EX
		POP AX
		POP DX		

		STI
		IRET
	ENDP


	Reside: ;etiqueta para determinar la dirección siguiente a la última de la rutina que debe quedar residente

		MOV DX, offset Rutina_Servicio
		MOV AX, 0
		MOV ES, AX
		;MOV SI, Codigo_Int*4
		MOV SI, 1Ch*4 
		CLI
		MOV ES:[SI], DX
		MOV ES:[SI+2], CS
		STI
		MOV DX, offset Reside
		INT 27h
	END Programa_Int 
