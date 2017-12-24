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
	
	;como sólo hay un segmento de datos, y el de código no se puede modificar (por cuestiones de seguridad)
	;en general serán innecesarios los prefijos de segmento en los direccionamientos
        
	MOV CX, 4
	MOV ESI, CADENA
	MOV EDI, PESO

	;Binario natural
	BUCLE:
		MOV AL, [ESI]
		MUL byte [EDI]
		ADD BX, AX
		INC ESI
		INC EDI
	LOOP BUCLE; Salir si CX = 0	
	
	MOV [BINARIO_NAT], BX
	
	;Complemento a 2
	MOV BX, 0
	MOV CX, 4
	MOV ESI, CADENA
	MOV EDI, PESO	
	
	BUCLE1:
		MOV AL, [ESI]
		MUL byte [EDI]
		ADD BX, AX
		
		INC ESI
		INC EDI 		
	LOOP BUCLE1
	         
	CMP byte [CADENA], 1
	JE RESTA_C2
	JNE SIGUE_C2
	
	RESTA_C2:
	    SUB BL, 14

	SIGUE_C2:	
		MOV [COMP_2], BL


	
	;Complemento a 1
	MOV BX, 0
	MOV ESI, CADENA
	MOV EDI, PESO
	MOV CX, 4
	
	BUCLE2:;Obtenemos valor en binario natural
		MOV AL, [ESI]
		MUL byte [EDI]
		ADD BX, AX
		
		INC ESI   
		INC EDI
	LOOP BUCLE2 
	
	CMP byte [CADENA], 1
	JE RESTA_C1
	JNE SIGUE_C1
	
	RESTA_C1:
	    SUB BL, 15
	              
	SIGUE_C1:
		MOV [COMP_1], BL


	;Exceso 2^(n-1)
	MOV BX, 0
	MOV CX, 4
	MOV ESI, CADENA
	MOV EDI, PESO
		
	BUCLE3:;Obtenemos el valor el binario natural
		MOV AL, [ESI]
		MUL byte [EDI]
		ADD BX, AX

		INC ESI
		INC EDI 
	LOOP BUCLE3
	
	SUB BX, 8;Restamos el exceso al resultado en binario natural
	MOV [EXCESO], BL

	;terminar la ejecución (AX=1)
	MOV EAX, 1
	INT 80h

section .data
	;Aqui los datos inicializados
	CADENA DB 1,1,1,1
	PESO DB 8,4,2,1
	BINARIO_NAT DB 0; Valor en binario natural
	COMP_1 DB 0
	COMP_2 DB 0
	EXCESO DB 0

