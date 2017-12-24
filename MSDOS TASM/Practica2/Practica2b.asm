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
		PUSH ES
		PUSH CX
		PUSH SI

		;Operaciones
		DEC CONTADOR
		JZ MOSTRAR_CRONO
		JMP SALIR
		
		MOSTRAR_CRONO:
			;Inicializar modo texto
			MOV AX, 0B800h
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
		
		JE SUMAR_MIN
		SUMAR_MIN:
		    INC MS[0]
		    MOV MS[1], 0
		;JMP Programa_Int
		JMP PINTA
		
		PINTA:
			MOV SI, 0;Posicion del reloj
			MOV CX, 5;Numero de iteraciones del bucle
			
			MOV DI, 4050 ;2x(80x25)+50
			
			BUCLE:
				MOV AL, MS[SI];Almacenamos contenido del reloj
				MOV ES:[DI], AL
				
				MOV AL, 11110000b;atributo del dato a mostrar por pantalla
				MOV ES:[DI+1], AL
				ADD DI, 2;cada pixel ocupa dos posiciones
				INC SI
			LOOP BUCLE
			
			MOV CONTADOR, 18;Reiniciamos el contador

		; Recupera el valor de los registros implicados en la rutina
		SALIR:
			POP SI
			POP CX
			POP ES
			POP AX
			POP DX		

			STI;Habilitar interrupciones
			IRET;devolver control al SO y recuperar pila
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
