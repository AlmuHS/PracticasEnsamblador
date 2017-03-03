section .text
	global _start
	cpu 386
_start:
        ;Aqui va el codigo
	
	;como sólo hay un segmento de datos, y el de código no se puede modificar (por cuestiones de seguridad), no hace falta indicarlo
	;en general serán innecesarios los prefijos de segmento en los direccionamientos
        
        MOV AX, [A]
        SUB AX, [B]
        SUB AX, [C]
	
	;terminar la ejecución (AX=1)
	MOV EAX,1
	INT 80h

section .data
	;Aqui los datos inicializados
	A DW 500
	B DW 400
	C DW 100

