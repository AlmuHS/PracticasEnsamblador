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
