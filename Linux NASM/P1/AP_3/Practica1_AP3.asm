section .text
	global _start
	cpu 386
_start:
        ;Aqui va el codigo
	
	;como sólo hay un segmento de datos, y el de código no se puede modificar (por cuestiones de seguridad)
	;en general serán innecesarios los prefijos de segmento en los direccionamientos
        
	MOV CX, 4
	MOV ESI, CADENA
	MOV EDI, EXT_BINAT

	;Binario natural 
	EXTENSION:
	    MOV AL, [ESI]
	    MOV [EDI+4], AL;Copiamos los bits significativos en las posiciones de menor peso
	    
	    INC ESI
	    INC EDI
	LOOP EXTENSION
	
	MOV ESI, EXT_BINAT+7
	MOV EDI, PESO + 7
	MOV BX, 0
	MOV CX, 7	

	BUCLE:;Aplicamos el calculo del binario natural sobre la cadena extendida
		MOV AL, [ESI]
		MUL byte [EDI]
		ADD BL, AL

		DEC ESI
		DEC EDI
	LOOP BUCLE;Salimos si SI = 0
		
	MOV [BINARIO_NAT], BL
	

	;Binario con signo
	MOV BL, [CADENA]
	MOV [EXT_BINSIG], BL;Copiamos el bit de signo en la posicion de mayor peso
	
	MOV ESI, CADENA + 1
	MOV EDI, EXT_BINSIG + 4
	MOV CX, 4
	
	EXT_SIG:;Obtenemos la cadena extendida
	    MOV AL, [ESI]
	    MOV [EDI], AL;Copiamos los bits significativos en las posiciones mas bajas
	    
	    INC ESI
		INC EDI
	LOOP EXT_SIG
	
	MOV ESI, CADENA + 1
	MOV EDI, PESO
	MOV BX, 0
	MOV CX, 8	

	SUMA:
	    MOV AL, [ESI]
	    MUL byte [EDI]
	    ADD BL, AL
	    
	    INC ESI
		INC EDI
	LOOP SUMA
    
	
	CMP byte [EXT_BINSIG], 1
	JE NEGATIVO
	JNE SEGUIR
	          
	          
	NEGATIVO:
	    NEG BX
	    
	SEGUIR:
		MOV [BIN_SIG], BL 
	    
	    

	;Complemento a 2
	MOV CX, 4
	MOV ESI, CADENA
	MOV EDI, EXT_C2

	
	COPIA_MP:;Copiamos el bit de mayor peso en las primeras 4 posiciones
		MOV AL, [CADENA]
		MOV [EDI], AL
        
        INC EDI
	LOOP COPIA_MP
	
	MOV ESI, CADENA
	MOV EDI, EXT_C2 + 4
	MOV CX, 4
	
	COPIA_BITS:;Copiamos el numero original en las 4 ultimas posiciones
		MOV AL, [ESI]
		MOV [EDI+4], AL

		INC ESI
		INC EDI
	LOOP COPIA_BITS
	
	MOV ESI, CADENA
	MOV EDI, PESO
	MOV CX, 8
	MOV DX, 0
	
	BUCLE1:;Calculamos valor en binario natural de la cadena extendida
		MOV AL, [ESI]
		MUL byte [EDI]
		ADD CL, AL
		
		INC ESI
		INC EDI   		
	LOOP BUCLE1
	         
	CMP byte [EXT_C2], 1;Comprobamos si el numero es negativo o positivo
	JE RESTA_C2
	JNE SIGUE_C2

	RESTA_C2:
	    MOV BL, 254
	    SUB BL, DL;Restamos (2^n)-2 = 14 para obtener el complemento
	    MOV DL, BL
	              
	SIGUE_C2:
	
	MOV [COMP_2], DL
	
	;Complemento a 1
	MOV CX, 4
	MOV EDI, EXT_C1
	
	COPIA_MP2:;Copiamos el bit de mayor peso en las primeras 4 posiciones
		MOV AL, [CADENA]
		MOV [EDI], AL

		INC EDI
	LOOP COPIA_MP2
	
	MOV ESI, EXT_C1 + 4
	MOV CX, 4
	
	COPIA_BITS2:;Copiamos el numero original en las 4 ultimas posiciones
		MOV AL, [CADENA]
		MOV [ESI+4], AL

		INC ESI
	LOOP COPIA_BITS2
	
	MOV ESI, EXT_C1
	MOV EDI, PESO
	MOV DL, 0
	MOV CX, 8
	
	BUCLE2:;Calculamos el valor en binario natural de la cadena extendida
		MOV AL, [ESI]
		MUL byte [EDI]
		ADD DL, AL
		
		INC ESI   		
	LOOP BUCLE2
	         
	CMP byte [EXT_C1], 1;Comprobamos si el numero es negativo o positivo
	JE RESTA_C1
	JNE SIGUE_C1
	
	RESTA_C1:
	    MOV BL, 255
	    SUB BL, DL;Restamos (2^n)-2 = 14 para obtener el complemento
	    MOV DL, BL
	              
	SIGUE_C1:
	
	MOV [COMP_1], CL
	        
	
	;Exceso 2^(n-1)
	MOV ESI, CADENA
	MOV EDI, EXT_EXCESO + 4
	MOV CX, 4
    
    EXTENSION_EX:
	    MOV AL, [ESI]
	    MOV [EDI], AL
	    
	    INC ESI
		INC EDI
	LOOP EXTENSION_EX
                    
    MOV ESI, EXT_EXCESO
	MOV EDI, PESO
	MOV BX, 0
	MOV CX, 8
                    
	BUCLE3:
		MOV AL, [ESI]
		MUL byte [EDI]
		ADD BX, AX

		INC ESI
		INC EDI   
	LOOP BUCLE3; Salir si SI > 7
	
	SUB BL, 8;Restamos el exceso al resultado en binario natural
	MOV [EXCESO], BL
	
	;terminar la ejecución (AX=1)
	MOV EAX, 1
	INT 80h

section .data
	CADENA DB 1,1,1,1
	PESO DB 128,64,32,16,8,4,2,1
	
	BINARIO_NAT DB 0; Valor en binario natural
	COMP_1 DB 0 
	COMP_2 DB 0
	EXCESO DB 0 
	BIN_SIG DB 0
	
	EXT_BINAT DB 0,0,0,0,0,0,0,0
	EXT_C2 DB 0,0,0,0,0,0,0,0
	EXT_C1 DB 0,0,0,0,0,0,0,0
	EXT_EXCESO DB 0,0,0,0,0,0,0,0
	EXT_BINSIG DB 0,0,0,0,0,0,0,0

