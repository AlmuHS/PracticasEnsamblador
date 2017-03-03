.MODEL SMALL

.DATA

	CADENA DB 1,1,1,1
	PESO DB 8,4,2,1
	BINARIO_NAT DB 0; Valor en binario natural
	COMP_1 DB 0
	COMP_2 DB 0
	EXCESO DB 0

		

.CODE

	MOV AX, SEG CADENA
  	MOV DS, AX

	MOV BX, 0
	MOV SI, 0

	;Binario natural
	BUCLE:
		MOV AL, CADENA[SI]
		MUL PESO[SI]
		ADD BX, AX

		INC SI; Incrementamos registro SI
		CMP SI, 4; Comparar SI con 0
	JB BUCLE; Salir si SI < 1
		
	MOV BINARIO_NAT, BL

	;Complemento a 2
	MOV CX, 0
	MOV SI, 0	
	
	BUCLE1:;Obtenemos valor en binario natural
		MOV AL, CADENA[SI]
		MUL PESO[SI]
		ADD CX, AX
		
		INC SI   		
		CMP SI, 4
	JB BUCLE1
	         
	CMP CADENA[0], 1
	JE RESTA_C2
	JNE SIGUE_C2
	
	RESTA_C2:
	    MOV BL, 14
	    SUB BL, CL;Restamos (2^n)-2 = 14 para obtener el complemento
	    MOV CL, BL
	              
	SIGUE_C2:
	
	MOV COMP_2, CL
	
	;Complemento a 1
	MOV CX, 0
	MOV SI, 0
	
    BUCLE2:;Obtenemos valor en binario natural
		MOV AL, CADENA[SI]
		MUL PESO[SI]
		ADD CX, AX
		
		INC SI   
		CMP SI, 4
	JB BUCLE2 
	
	CMP CADENA[0], 1
	JE RESTA_C1
	JNE SIGUE_C1
	
	RESTA_C1:
	    MOV BL, 15
	    SUB BL, CL;Restamos (2^n)-2 = 14 para obtener el complemento
	    MOV CL, BL
	              
	SIGUE_C1:
	    
	MOV COMP_1, CL
	        
	
	;Exceso 2^(n-1)
	MOV BX, 0
	MOV SI, 0
		
	BUCLE3:;Obtenemos el valor el binario natural
		MOV AL, CADENA[SI]
		MUL PESO[SI]
		ADD BX, AX

		INC SI 
		CMP SI, 4
	JB BUCLE3
	
	SUB BX, 8;Restamos el exceso al resultado en binario natural
	MOV EXCESO, BL
	
	MOV AH, 4Ch
	INT 21h

END
