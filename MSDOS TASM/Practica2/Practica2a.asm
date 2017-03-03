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
