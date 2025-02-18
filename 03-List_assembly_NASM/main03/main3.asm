extern printf
global main

section .data
    nums dd 11, 20, 3, 16, 34, 25, 35, 38, 185, 500  ; 10 constantes numéricas inteiras
    
    ; Formato para imprimir o menor número
    fmt_menor db "O menor número entre as constantes eh: %d", 0AH, 0H    
    
    ; Formato para imprimir o maior número
    fmt_maior db "O maior número entre as constantes eh: %d", 0AH, 0H    

section .bss
    menor_num resd 1	; Armazenará o menor número
    maior_num resd 1	; Armazenará o maior número

section .text

main:
    ; Inicializa os registradores
    mov esi, nums       	; ESI aponta para o início do array nums
    mov eax, [esi]      	; EAX recebe o primeiro número
    mov [menor_num], eax  	; Inicializa min_num com o primeiro número
    mov [maior_num], eax  	; Inicializa max_num com o primeiro número

    ; Loop para encontrar o menor e o maior número
    mov ecx, 9          	; Contador para os 9 números restantes (já processamos o primeiro)
    
encontrar_menor_maior:
    add esi, 4          	; Avança para o próximo número
    mov eax, [esi]      	; Carrega o próximo número em EAX

    ; Verifica se é o menor número
    mov ebx, [menor_num]  	; Carrega o menor número atual em EBX
    cmp eax, ebx        	; Compara EAX com EBX
    jge pula_menor        	; Se EAX >= EBX, pula a atualização do menor número
    mov [menor_num], eax  	; Atualiza min_num com o novo menor número

pula_menor:
    ; Verifica se é o maior número
    mov ebx, [maior_num]  	; Carrega o maior número atual em EBX
    cmp eax, ebx        	; Compara EAX com EBX
    jle pula_maior        	; Se EAX <= EBX, pula a atualização do maior número
    mov [maior_num], eax  	; Atualiza max_num com o novo maior número

pula_maior:
    loop encontrar_menor_maior   ; Decrementa ECX e repete o loop se ECX > 0

    ; Exibe o menor número
    push dword [menor_num]
    push fmt_menor
    call printf
    add esp, 8

    ; Exibe o maior número
    push dword [maior_num]
    push fmt_maior
    call printf
    add esp, 8

    ; Fim do programa
    mov eax, 1          ; syscall number for sys_exit
    xor ebx, ebx        ; exit status 0
    int 0x80            ; chamada de sistema

