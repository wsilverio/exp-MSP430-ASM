#include <msp430.h>

// Mascaras dos perifericos
#define led_verde   0x40        //0[1]00-0000
#define led_vermelho    0x01    //0000-000[1]
#define botao       0x08        //0000-[1]000

ORG 0xFFFE      // vetor RESET
DC16    main    // carrega o programa

RSEG    CODE    // memoria de programa
main:   
    mov.w   #WDTPW + WDTHOLD,   &WDTCTL // desabilita whatchdog
    mov.w   #0x0400,    SP      // inicializa a pilha
    
    mov.b   #0x41,      &P1DIR  // define os leds como saida [1] e o botao como entrada [0]: 0[1]00-[0]00[1]
    mov.b   #0x08,      &P1REN  // habilita o resistor pull-up no botao: 0000-[1]000
    mov.b   #0x08,      &P1OUT  // apaga os leds e ativa o pull-up no botao: 0000-[1]000
    
loop:   bit.b   #botao,     &P1IN   // testa bit P1.3 (botao)

    jz  verde       // if botao == press: verde()
                    // else: vermelho()

vermelho:
    bic.b   #led_verde, &P1OUT      // apaga led verde
    bis.b   #led_vermelho,  &P1OUT  // acende led verm
    jmp loop
verde:  
    bic.b   #led_vermelho,  &P1OUT  // apaga led verm
    bis.b   #led_verde, &P1OUT      // acende ler verde
    jmp loop
    
end 
