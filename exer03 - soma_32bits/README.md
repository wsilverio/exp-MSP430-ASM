Autor: [twitter.com/obelonave](https://twitter.com/obelonave)
Licenca: [CC-BY](http://creativecommons.org/licenses/)

CPU: MSP430G2553
Testado com simulador [IAR Embedded Workbench for TI MSP430 6.10](http://www.iar.com/Products/IAR-Embedded-Workbench/TI-MSP430/)


Referente a disciplina [TE124 - Microcontroladores](http://www.eletrica.ufpr.br/p/disciplinas:te124)  / Universidade Federal do Parana (2014/2)

Exer 3 - soma 32 bits

Ao final do exercicio 01 (enderecamentos), a memoria RAM ficou com os seguintes
dados armazenados (os valores estao em hexadecimal):

0x0240: 7698 7856
0x0250: 5380 5913

Somar os valores, considerando que os mesmos representam dois numeros binarios
de 32 bits. Os enderecos 0x0240 e 0x0250 contem os 16 bits menos significativos e
os enderecos 0x0242 e 0x0252 contem os 16 bits mais significativos.
Armazenar a soma nos enderecos 0x0260 e 0x0262 respectivamente.
0x0240: 7698 7856
0x0250: 5380 5913
0x0260: C918 D269