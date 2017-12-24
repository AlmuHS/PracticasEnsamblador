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


.MODEL SMALL

.DATA

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

		

.CODE

	MOV AX, SEG CADENA
  	MOV DS, AX

	MOV BX, 0
	MOV SI, 0

	;Binario natural 
	EXTENSION:
	    MOV AL, CADENA[SI]
	    MOV EXT_BINAT[SI+4], AL
	    
	    INC SI
	    CMP SI, 4
	JB EXTENSION
	
	MOV SI, 7
	
	BUCLE:
		MOV AL, EXT_BINAT[SI]
		MUL PESO[SI]
		ADD BL, AL

		DEC SI; Incrementamos registro SI
	JNZ BUCLE; Salir si SI < 1
		
	MOV BINARIO_NAT, BL
	
	;Binario con signo
	MOV BL, CADENA[0]
	MOV EXT_BINSIG[0], BL;Copiamos el bit de signo
	
	MOV SI, 0
	MOV BX, 0
	
	EXT_SIG:;Copiamos los bits significativos
	    MOV AL, CADENA[SI]
	    MOV EXT_BINSIG[SI+4], AL
	    
	    INC SI
	    CMP SI, 4
	JB EXT_SIG
	
	MOV SI, 1
	
	SUMA:
	    MOV AL, EXT_BINSIG[SI]
	    MUL PESO[SI]
	    ADD BL, AL
	    
	    INC SI
	    CMP SI, 8
	JB SUMA
    
	
	CMP EXT_BINSIG[0], 1
	JE NEGATIVO
	JNE SEGUIR
	          
	          
	NEGATIVO:
	    NEG BX
	    
	SEGUIR:
	
	MOV BIN_SIG, BL 
	    
	    

	;Complemento a 2
	MOV CX, 0
	MOV SI, 0
	
	COPIA_MP:;Copiamos el bit de mayor peso en las primeras 4 posiciones
		MOV AL, CADENA[0]
		MOV EXT_C2[SI], AL
        
        INC SI
		CMP SI, 4
	JB COPIA_MP
	
	MOV SI, 0
	
	COPIA_BITS:;Copiamos el numero original en las 4 ultimas posiciones
		MOV AL, CADENA[SI]
		MOV EXT_C2[SI+4], AL

		INC SI
		CMP SI, 4
	JB COPIA_BITS
	
	MOV SI, 0
	
	BUCLE1:
		MOV AL, EXT_C2[SI]
		MUL PESO[SI]
		ADD CL, AL
		
		INC SI
		CMP SI, 8   		
	JB BUCLE1
	         
	CMP EXT_C2[0], 1
	JE RESTA_C2
	JNE SIGUE_C2
	
	RESTA_C2:
	    SUB CL, 254
	              
	SIGUE_C2:
	
	MOV COMP_2, CL
	
	;Complemento a 1
	MOV CX, 0
	MOV SI, 0
	
	COPIA_MP2:;Copiamos el bit de mayor peso en las primeras 4 posiciones
		MOV AL, CADENA[0]
		MOV EXT_C1[SI], AL

		INC SI
		CMP SI, 4
	JB COPIA_MP2
	
	MOV SI, 0
	
	COPIA_BITS2:;Copiamos el numero original en las 4 ultimas posiciones
		MOV AL, CADENA[SI]
		MOV EXT_C1[SI+4], AL

		INC SI
		CMP SI, 4
	JB COPIA_BITS2
	
	MOV SI, 0
	
	BUCLE2:
		MOV AL, EXT_C1[SI]
		MUL PESO[SI]
		ADD CL, AL
		
		INC SI
		CMP SI, 8   		
	JB BUCLE2
	         
	CMP EXT_C1[0], 1
	JE RESTA_C1
	JNE SIGUE_C1
	
	RESTA_C1:
	    SUB CX, 255
	              
	SIGUE_C1:
	
	MOV COMP_1, CL
	        
	
	;Exceso 2^(n-1)
	MOV BX, 0
	MOV SI, 0
    
    EXTENSION_EX:
	    MOV AL, CADENA[SI]
	    MOV EXT_EXCESO[SI+4], AL
	    
	    INC SI
	    CMP SI, 4
	JB EXTENSION_EX
                    
    MOV SI, 0 
                    
	BUCLE3:
		MOV AL, EXT_EXCESO[SI]
		MUL PESO[SI]
		ADD BX, AX

		INC SI   
		CMP SI, 8; Comparar SI con 0
	JB BUCLE3; Salir si SI > 7
	
	ADD BL, 8;Sumamos el exceso al resultado en binario natural
	MOV EXCESO, BL
	
	MOV AH, 4Ch
	INT 21h

END
