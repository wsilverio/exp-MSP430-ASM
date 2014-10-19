ORG     0xFFFE        // posiciona endereco 0xFFFE (vetor RESET)
DC16    main          // carrega o programa "main" no endereco atual

#define var_1   0x0206  // constante var_1 por 0x0206

ASEG    0x0200      // mem dados (RAM)
var_2:  DS8 1       // reserva 1 byte (8 bits) para a variavel var_2
    align   1       // alinha para o proximo endereco de 1 word (endereco par)
var_3:  DS16    16  // reserva 1 word (16 bits) para a variavel var_3

RSEG    CODE        // memoria de programa
main:
    // enderecamento imediato
    mov.w   #0x0240,    R5
    mov.w   #0x0250,    R10
    mov.w   #0x58,      R12
    mov.w   #0x8053,    R13

    // enderecamento absoluto
    //mov.w #0x5678,    &0x0206 
    mov.w   #0x5678,    &var_1

    // enderecamento simbolico
    mov.b   R12,        var_2
    mov.w   #0x1359,    var_3
        
    // enderecamento indexado
    mov.w   #0x9876,    0(R5)   // (deslocamento 0) - endereco apontado pelo R5
    mov.w   R13,        0(R10)  // (deslocamento 0) - endereco apontado pelo R10
        
    add.w   #2,         R5      // R2 += 2
    add.w   #2,         R10     // R10 += 2
        
    mov.w   &var_1,     0(R5)   // move o CONTEUDO do endereco absoluto (0x0206) para o endereco apontado pelo R5 (0x0242)
    mov.w   var_3,      0(R10)  
    mov.b   var_2,      R15     // operacao com byte -> move o valor para o LSB e zera o HSB
        
    // somar a word armazenada no endereco 0x0240 com a word do endereco 0x0250 e armazenar no endereco 0x0260
    // somar a word armazenada no endereco 0x0242 com a word do endereco 0x0252 e armazenar no endereco 0x0262
    mov.w   #0x0240,        R5
    mov.w   #0x0250,        R10
    mov.w   #0x0260,        R7
        
    mov.w   @R5,            0(R7)   // pega o conteudo do endereco apontado pelo R5 e move para o endereco apontado pelo R7
    add.w   @R10,           0(R7)   // pega o conteudo do endereco apontado pelo R10 e adiciona ao conteudo apontado pelo R7. o resultado fica no endereco apontado pelo R7
        
    add.w   #2,             R5      // enunciado diz 2 "casas" para frente porque esta trabalhando com word
    add.w   #2,             R10
    add.w   #2,             R7
        
    mov.w   @R5,            0(R7)   // pega o conteudo do endereco apontado pelo R5 e move para o endereco apontado pelo R7
    add.w   @R10,           0(R7)   // pega o conteudo do endereco apontado pelo R10 e adiciona ao conteudo apontado pelo R7. o resultado fica no endereco apontado pelo R7
        

fim:    jmp fim // ou jmp $

end // fim do programa
