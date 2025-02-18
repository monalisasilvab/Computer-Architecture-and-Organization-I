extern printf
global main

section .data
    ; Array de 10 números inteiros (WORD)
    array dw 8, 22, 26, 84, 91, 111, 250, 300, 350, 400  
    
    ; Formato para imprimir a soma
    fmt db "A soma dos números é: %d", 0AH, 0H      

section .bss
    soma resd 1  ; Variável para armazenar a soma

section .text

main:
    ; Inicializa o ponteiro e o acumulador
    mov esi, array     	; Ponteiro para o início do array
    xor eax, eax       	; Zera o acumulador

    ; Loop para somar os números
    mov ecx, 10        ; Número de elementos no array

soma_loop:
    movzx ebx, word [esi]  	; Carrega o próximo número (WORD) em ebx com zero-extensão
    add eax, ebx           	; Adiciona o número ao acumulador
    add esi, 2             	; Avança o ponteiro para o próximo número (cada WORD tem 2 bytes)
    loop soma_loop          	; Decrementa ecx e repete o loop se não for zero

    ; Armazena a soma em sum
    mov [soma], eax

    ; Exibe a soma
    push eax              	; Empilha a soma para printf
    push fmt              	; Empilha a string de formato para printf
    call printf           	; Chama printf
    add esp, 8            	; Limpa a pilha

    ; Finaliza o programa
    mov eax, 1            	
    xor ebx, ebx          	; exit status 0
    int 0x80              	; chamada de sistema

