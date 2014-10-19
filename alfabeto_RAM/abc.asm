/*
	Escrever na memoria RAM as letras maiusculas do alfabeto

	Tabela ASCII:
		A -> 0x41
		[...]
		Z -> 0x5A

	RAM:
		0x0200: A
		[...]
		0x0219: Z

	Registradores:
		R10: caractere
		R12: endereco

	Watchdog:
		WDTPW: 0x5A00 senha
		WDTHOLD: 0x0080 desabilita WDT
		WDTCTL: senha + (hab ou des)

	Pilha:
		SP: 0x0400 -> inicializa a pilha em 0x03FF (final da RAM)

*/

#include <msp430.h> // msp430g2553.h

ORG	0xFFFE			// vetor RESET
	DC16	setup		

RSEG	CODE	// ORG 0xC000
setup:  
	mov.w	#WDTPW + WDTHOLD, &WDTCTL	// desabilita WDT
    mov.w	#0x0400,	SP				// inicializa a pilha
	
	mov.b	#0x41,		R10	// 'A'
	mov.w	#0x200,		R12	// ponteiro - inicio da RAM

main:	
	mov.b	R10,		0(R12)	// move o caractere em R10 para o endereco apontado por R12
	
	cmp.b	#0x5A,		R10		// 0x5A = 'Z'
	
	// R10 == 'Z'
	jz	fim
	
	// R10 != 'Z'
	inc	R10		// R10++
	inc	R12		// R12++
	jmp	main	// loop

fim:    jmp		fim
end
