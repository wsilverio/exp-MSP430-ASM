#include <msp430.h>

ORG 0xFFFE          // Reset
    DC16    setup   // Carrega o programa no endereco

RSEG    CODE        // Memoria de programa
setup:  
    mov.w   #WDTPW + WDTHOLD,   &WDTCTL // desabilita WDT
    mov.w   #0x0400,    SP      // incializa a pilha
    
    mov.w   #nome,      R10     // carrega o endereco da string 'nome'
    mov.w   #0x0200,    R12     // carrega o endereco para a string copiada

main:   
    mov.b   @R10+,      0(R12)  // copia o caractere apontado pelo R10 para o endereco apontado pelo R12
    
    cmp.b   #0x01,      0(R10)  // verifica se a string chegou ao fim
    
    // if @R10 == 0x01
    jz  fim
    
    // else
    inc R12 // R12++
    jmp main

fim:    jmp $

/* 0x01 = fim da string
    OBS: 0x01 sempre ficara em um end PAR. Isso gerara um loop desnecessario quando a string tambem terminar em um end PAR,
    pois entre eles ha um endereco IMPAR, comparado com @10 {**Colocar o fim da string dentro dela mesma?**}
*/
nome:   DB "wsilverio - Universidade Federal do Parana", 0x01 // string e fim da string
    
end
