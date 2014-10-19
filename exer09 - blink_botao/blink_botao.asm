#include <msp430.h>

// Mascaras dos perifericos
#define verde       0x40    // 0100_0000
#define vermelho    0x01    // 0000_0001
#define botao       0x08    // 0000_1000

ORG 0xFFFE          // reset
DC16    main

ASEG    0x0200  // RAM
pisca:  DS8 1   // flag pisca
align       1   
p13a:   DS8 1   // P1.3_Anterior: carrega o estado anterior do botao
align       1
cont:   DS16    1  // variavel para contagem do tempo
    
RSEG    CODE
main:   
    // A pilha deve ser inicializada antes de chamar qualquer funcao com retorno
    mov.w   #0x0400,    SP  // inicializa a pilha
    call    #setup
        
loop:   
    bit.b   #botao, &P1IN   // testa bit P1.3 (AND)

    jnz set_p13a        // if(botao not press): goto set_p13a()
    call    #bot_press  // else: bot_press()
    jmp continua
    
set_p13a:
    mov.b   #1, p13a    // estado anterior = HIGH
    
continua:
    cmp.b   #1, pisca
    jnz loop            // se pisca == 0: resultado == -1
    call    #pisca_leds // se pisca == 1: resultado == 0
    jmp loop    

setup:  
    mov.w   #WDTPW + WDTHOLD,   &WDTCTL // desabilita whatchdog
    
    mov.b   #0x41,      &P1DIR  // 0100_0001 in/out
    mov.b   #0x08,      &P1REN  // 0000_1000 enable pullup/down
    mov.b   #0x08,      &P1OUT  // 0000_1000 ativa o pullup do botao e apaga os leds
    
    mov.b   #1,     p13a    // seta como se o botao estivesse em '1'
    mov.b   #0,     pisca   // nao pisca no comeco
    ret
    
bot_press:
    cmp.b   #1, p13a    // testa o estado anterior
    jnz ret_bot         // if(anterior == LOW): ret
    mov.b   #0, p13a    // else: anterior = HIGH
    xor.b   #1, pisca   // inverte a variavel
    
    cmp.b   #1, pisca
    jnz apagar_leds             // if(pisca == 0): leds = LOW
    bis.b   #vermelho,  &P1OUT  // else: vermelho = HIGH
    jmp ret_bot

apagar_leds:
    bic.b   #vermelho + verde,  &P1OUT  // apaga os dois leds
ret_bot:
    ret

pisca_leds:
    xor.b   #vermelho + verde,  &P1OUT  //b'01000001 | alterna os leds INDIVIDUALMENTE ao mesmo tempo
    call    #delay_250ms
    ret
    
delay_250ms:
    mov.w   #62498,     cont    // X ciclos ???
    decre:  nop                 // 1 ciclo ?
        dec.w       cont        // 1 ciclos ? 
        jnz     decre           // 2 ciclos ?
        ret                     // 1 ciclo ?
    ret 
    
end 