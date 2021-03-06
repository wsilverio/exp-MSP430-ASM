ORG    0xFFFE   // posiciona endereco 0xFFFE (vetor RESET)
DC16   main     // carrega o programa "main" no endereco atual

#define var_1   0x0206  // subst var_1 por 0x0206

ASEG    0x0200  // mem dados (RAM)
var_2:  DS8 1   // reserva 1 byte
    align   1   // alinhamento
var_3:  DS16    1   // reserva 1 word - (num endereco par)

RSEG    CODE    // memoria de programa
main:   
    mov.w   #0x0240,    R5  // enderecamento imediato
    mov.w   #0x0250,    R10
    mov.w   #0x58,      R12
    mov.w   #0x8053,    R13

    //mov.w     #0x5678,    &0x0206 // enderecamento absoluto
    mov.w   #0x5678,    &var_1  // absoluto

    mov.b   R12,        var_2   // simbolico
    mov.w   #0x1359,    var_3   // simbolico
        
    mov.w   #0x9876,        0(R5)   // indexado (deslocamento 0) - endereco apontado pelo R5
    mov.w   R13,            0(R10)  // indexado - endereco apontado pelo R10
        
    add.w   #2,             R5      // soma 2 ao registrador R5 -> 2 cte decimal (.w: reg e de 16 bits)
    add.w   #2,             R10
        
    mov.w   &var_1,         0(R5)   // move o CONTEUDO do endereco absoluto (0x0206) para o endereco apontado pelo 0x0242)
    mov.w   var_3,          0(R10)
    mov.b   var_2,          R15     // operacao com byte -> move o valor para o LSB e zera o HSB
        
    // somar a word de 32-bits armazenada no end 0x0240 e 0x250 e armazenar no end 0x0260
    mov.w   #0x0240,        R5
    mov.w   #0x0250,        R10
    mov.w   #0x0260,        R7
        
    // soma do LSB
    mov.w   @R10+,          0(R7)   // pega o conteudo do endereco apontado pelo R10 e move para o endereco apontado pR7, depois, automaticamente ele incrementa (para word) o R10
    add.w   @R5+,           0(R7)   // pega o conteudo do endereco apontado pelo R5 e adiciona ao conteudo apontado pR7. o resultado fica no endereco apontado pelo R7. depois, automaticamente ele incrementa (para word) o R5
    // soma do HSB
    mov.w   @R10,           2(R7)   
    addc.w  @R5,            2(R7)   // adicao com o carry
             

fim:    jmp fim // ou jmp $

end     // fim do programa