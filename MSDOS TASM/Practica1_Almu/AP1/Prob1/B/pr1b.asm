.MODEL SMALL

.DATA
	A DW 500
	B DW 400
	C DW 100

.CODE
	
	MOV AX, A ;movemos la variable A al registro acumulador AX
	SUB AX, B ;restamos a AX el valor de B
	SUB AX, C ;restamos a AX el valor de C
	
	MOV AH, 4ch
	INT 21h
END
