extern printf
global main

section .data
    ; Array de 5 números inteiros (WORD)
    array dw 2, 3, 7, 8, 9         
    
    ; Formato para imprimir a multiplicação
    fmt db "O resultado da multiplicação é: %d", 0AH, 0H 

section .bss
    produto resd 1                  ; Variável para armazenar o produto

section .text

main:
    ; Inicializa o ponteiro e o acumulador
    mov esi, array     	; Ponteiro para o início do array
    mov eax, 1         	; Inicializa o acumulador com 1

    ; Loop para multiplicar os números
    mov ecx, 5         ; Número de elementos no array

multiplica_loop:
    movzx ebx, word [esi] 	; Carrega o próximo número (WORD) em ebx com zero-extensão
    imul eax, ebx          	; Multiplica eax por ebx, resultado em eax
    add esi, 2             	; Avança o ponteiro para o próximo número (cada WORD tem 2 bytes)
    loop multiplica_loop     	; Decrementa ecx e repete o loop se não for zero

    ; Armazena o produto em product
    mov [produto], eax

    ; Exibe o produto
    push eax              	; Empilha o produto para printf
    push fmt             	; Empilha a string de formato para printf
    call printf           	; Chama printf
    add esp, 8           	; Limpa a pilha

    ; Finaliza o programa
    mov eax, 1            	; syscall number for sys_exit
    xor ebx, ebx          	; exit status 0
    int 0x80              	; chamada de sistema
