section .text
	global _start
	cpu 386
_start:
        ;Aqui va el codigo
	
	;como sólo hay un segmento de datos, y el de código no se puede modificar (por cuestiones de seguridad)
	;en general serán innecesarios los prefijos de segmento en los direccionamientos
        
        MOV EAX, 4        ; SYS_WRITE SYSCALL

    	MOV EBX, 1        ; STDOUT

    	MOV ECX, MSG    ; MESSAGE ADDRESS

    	MOV EDX, LENGTH        ; message string length

	INT 80h
	
	;terminar la ejecución (AX=1)
	MOV EAX, 1        ; SYS_EXIT SYSCALL
	MOV EBX, 0        ; RETURN 0 (SUCCESS)
    	INT 80h

section .data
	;Aqui los datos inicializados
	MSG DB "HOLA",0x0A
	LENGTH: EQU $-MSG
