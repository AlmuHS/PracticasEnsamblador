;Copyright 2016 Almudena Garcia Jurado-Centurion

;This file is part of practica2.

;practica2 is free software: you can redistribute it and/or modify
;it under the terms of the GNU General Public License as published by
;the Free Software Foundation, either version 3 of the License, or
;(at your option) any later version.

;practica2 is distributed in the hope that it will be useful,
;but WITHOUT ANY WARRANTY; without even the implied warranty of
;MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;GNU General Public License for more details.

;You should have received a copy of the GNU General Public License
;along with practica2.  If not, see <http://www.gnu.org/licenses/>.


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
