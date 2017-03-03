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

