#define var_1   0x0206  // constante var_1 = 0x0206

ORG     0xFFFE  // posiciona o PC no endereco 0xFFFE (vetor RESET)
DC16    main    // carrega o programa "main" no endereco atual


ASEG    0x0200      // memoria de dados (RAM)
var_2:  DS8 1       // reserva 1 byte (8 bits) para a variavel var_2
    align   1       // alinha para o proximo endereco de 1 word (endereco par) - o alinhamento so e feito quando necessario

var_3:  DS16    1   // reserva 1 word (16 bits) para a variavel var_3

RSEG    CODE        // memoria de programa
main:   
    mov.w   #0x0240,    R5  // enderecamento imediato
    mov.w   #0x0250,    R10 // enderecamento imediato
    mov.w   #0x58,      R12 // enderecamento imediato
    mov.w   #0x8053,    R13 // enderecamento imediato

    //mov.w #0x5678,    &0x0206 // enderecamento absoluto
    mov.w   #0x5678,    &var_1  // enderecamento absoluto

    mov.b   R12,        var_2   // enderecamento simbolico
    mov.w   #0x1359,    var_3   // enderecamento simbolico
        
    mov.w   #0x9876,    0(R5)   // enderecamento indexado (deslocamento 0) - endereco apontado pelo R5
    mov.w   R13,        0(R10)  // enderecamento indexado - endereco apontado pelo R10
        
    add.w   #2,         R5  // R2 += 2
    add.w   #2,         R10 // R10 += 2
        
    mov.w   &var_1,     0(R5)   // move o CONTEUDO do endereco absoluto (0x0206) para o endereco apontado pelo R5 (0x0242)
    mov.w   var_3,      0(R10)
    mov.b   var_2,      R15     // move o valor para o LSB e zera o HSB
        

fim:    jmp fim         // fim do programa

end
