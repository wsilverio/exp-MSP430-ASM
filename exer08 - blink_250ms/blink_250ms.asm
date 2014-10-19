#include <msp430.h>

ORG 0xFFFE
DC16    main
    
ASEG    0x0200
var_cont:   DS16    1

RSEG    CODE
main:   
    mov.w   #WDTPW + WDTHOLD,   &WDTCTL // desabilita whatchdog
    mov.w   #0x0400,    SP  // inicializa a pilha
    
    mov.b   #0x41,  &P1DIR  // 0[1]00[0]00[1] -> 1: saida | 0: entrada
    
    mov.b   #1,     &P1OUT  // acende o led vermelho
    
loop:
    call    #inv_leds
    jmp loop

inv_leds:
    xor.b   #0x41,  &P1OUT  // 0[1]00000[1]B -> alterna os leds
    call    #delay_250ms
    ret
    
delay_250ms:
    mov.w       #62498,     var_cont    // 1 ciclo ???
    decre:
        nop                 // 1 ciclo
        dec.w   var_cont    // 1 ciclo ?
        jnz     decre       // 2 ciclos ?
        ret                 // 3 ciclos ?
    
end
