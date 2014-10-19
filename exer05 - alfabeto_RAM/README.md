Autor: [twitter.com/obelonave](https://twitter.com/obelonave)
Licenca: [CC-BY](http://creativecommons.org/licenses/)

CPU: MSP430G2553
Testado com simulador [IAR Embedded Workbench for TI MSP430 6.10](http://www.iar.com/Products/IAR-Embedded-Workbench/TI-MSP430/)


Referente a disciplina [TE124 - Microcontroladores](http://www.eletrica.ufpr.br/p/disciplinas:te124)  / Universidade Federal do Parana (2014/2)

##### Exer 5 - Escreve o alfabeto na RAM

* R10: caractere ascii
* R12: endereço da memória

###### Tabela ASCII:  

* 'A' -> 0x41
* [...]
* 'Z' -> 0x5A

###### RAM:

 * 0x0200: 'A'
 * [...]
 * 0x0219: 'Z'