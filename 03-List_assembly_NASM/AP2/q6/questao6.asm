section .data
    prompt db "Digite uma matriz 6x3:", 10, 0
    msg_max db "Maior elemento: %d (linha %d, coluna %d)", 10, 0
    msg_min db "Menor elemento: %d (linha %d, coluna %d)", 10, 0
    format db "%d", 0

section .bss
    matrix resd 18         ; Espaço para armazenar 6x3 = 18 inteiros
    max_value resd 1       ; Para armazenar o maior valor
    min_value resd 1       ; Para armazenar o menor valor
    max_pos resd 2         ; Para armazenar a posição do maior valor (linha e coluna)
    min_pos resd 2         ; Para armazenar a posição do menor valor (linha e coluna)

section .text
    extern printf, scanf
    global main

main:
    ; Solicitar a matriz ao usuário
    push dword prompt      ; Empilhar a mensagem de solicitação
    call printf            ; Chamar printf para exibir a mensagem
    add esp, 4             ; Limpar a pilha (1 * 4 bytes)

    ; Ler a matriz 6x3
    mov ecx, 18            ; Contador de elementos
    lea edi, [matrix]      ; Endereço da matriz

read_matrix:
    push dword format      ; Formato para scanf
    push dword edi         ; Endereço do próximo elemento da matriz
    call scanf             ; Ler um elemento
    add esp, 8             ; Limpar a pilha (2 * 4 bytes)
    add edi, 4             ; Avançar para o próximo elemento
    loop read_matrix       ; Repetir até ler todos os elementos

    ; Inicializar variáveis
    mov eax, [matrix]      ; Carregar o primeiro elemento
    mov [max_value], eax   ; Inicializar maior valor
    mov [min_value], eax   ; Inicializar menor valor
    mov dword [max_pos], 0 ; Inicializar posição do maior valor (linha e coluna)
    mov dword [min_pos], 0 ; Inicializar posição do menor valor (linha e coluna)
    mov edi, 0             ; Contador de elementos

find_max_min:
    mov eax, [matrix + edi*4] ; Carregar o próximo elemento
    cmp eax, [max_value]     ; Comparar com o maior valor
    jg new_max               ; Se for maior, atualizar
    cmp eax, [min_value]     ; Comparar com o menor valor
    jl new_min               ; Se for menor, atualizar
    jmp continue_loop

new_max:
    mov [max_value], eax     ; Atualizar maior valor
    mov eax, edi
    call get_position         ; Converter índice para linha e coluna
    mov [max_pos], eax       ; Atualizar posição do maior valor
    jmp continue_loop

new_min:
    mov [min_value], eax     ; Atualizar menor valor
    mov eax, edi
    call get_position         ; Converter índice para linha e coluna
    mov [min_pos], eax       ; Atualizar posição do menor valor

continue_loop:
    inc edi                  ; Avançar para o próximo elemento
    cmp edi, 18              ; Verificar se todos os elementos foram processados
    jl find_max_min          ; Se não, continuar

    ; Mostrar o maior elemento e sua posição
    mov eax, [max_value]     ; Maior valor
    push eax                 ; Empilhar maior valor
    mov eax, [max_pos]       ; Posição do maior valor
    push eax                 ; Empilhar linha e coluna
    mov eax, [max_pos + 4]
    push eax
    push dword msg_max       ; Mensagem para printf
    call printf              ; Chamar printf
    add esp, 16              ; Limpar a pilha (4 * 4 bytes)

    ; Mostrar o menor elemento e sua posição
    mov eax, [min_value]     ; Menor valor
    push eax                 ; Empilhar menor valor
    mov eax, [min_pos]       ; Posição do menor valor
    push eax                 ; Empilhar linha e coluna
    mov eax, [min_pos + 4]
    push eax
    push dword msg_min       ; Mensagem para printf
    call printf              ; Chamar printf
    add esp, 16              ; Limpar a pilha (4 * 4 bytes)

    ; Encerrar o programa
    mov eax, 1              ; syscall number para sys_exit
    xor ebx, ebx            ; código de saída 0
    int 0x80                ; chamada ao kernel

; Procedimento para calcular a posição em linha e coluna
; Receives: EAX = índice do elemento
; Returns: EAX = linha e coluna (linha, coluna)
get_position:
    mov ebx, 3              ; Número de colunas
    xor edx, edx            ; Limpar o resto
    div ebx                 ; Dividir índice por número de colunas
    mov ecx, eax            ; Linha
    mov eax, edx            ; Coluna
    shl ecx, 16             ; Deslocar a linha para a posição alta
    or eax, ecx             ; Combinar linha e coluna
    ret

