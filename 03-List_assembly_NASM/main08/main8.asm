extern printf
global main

section .data
    ; Array de 10 números inteiros (WORD)
    array dw 45, 23, 89, 12, 56, 78, 34, 67, 90, 21  
    
    ; Formato para imprimir o segundo menor
    fmt_segundo_menor db "O segundo menor número é: %d", 0AH, 0H 
    
    ; Formato para imprimir o segundo maior
    fmt_segundo_maior db "O segundo maior número é: %d", 0AH, 0H 

section .bss

section .text

main:
    ; Inicializa os ponteiros e contadores
    mov esi, array     ; Ponteiro para o início do array
    mov ecx, 10        ; Número de elementos no array

    ; Bubble sort para ordenar o array
bubble_sort:
    mov ecx, 10
    dec ecx
    xor edi, edi       ; Índice para comparacao
    
externo_loop:
    mov ebx, ecx       ; Inicializa ebx com ecx
    xor edi, edi       ; Reinicializa o índice
    
interno_loop:
    mov ax, [array + edi*2]
    cmp ax, [array + edi*2 + 2]
    jle pular_swap
    ; Swap dos valores
    xchg ax, [array + edi*2 + 2]
    mov [array + edi*2], ax
    
pular_swap:
    inc edi
    dec ebx
    jnz interno_loop
    dec ecx
    jnz externo_loop

    ; Carrega o segundo menor valor (array[1]) e imprime
    movzx eax, word [array + 2] ; Carrega o segundo menor valor
    push eax
    push fmt_segundo_menor
    call printf
    add esp, 8

    ; Carrega o segundo maior valor (array[8]) e imprime
    movzx eax, word [array + 16] ; Carrega o segundo maior valor
    push eax
    push fmt_segundo_maior
    call printf
    add esp, 8

    ; Finaliza o programa
    mov eax, 1            ; syscall number for sys_exit
    xor ebx, ebx          ; exit status 0
    int 0x80              ; chamada de sistema

