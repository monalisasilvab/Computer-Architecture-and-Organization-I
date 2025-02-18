extern printf
global main

section .data
    num dd 8                				; Inicializa a constante numérica
    fmt_par db "O número %d é par.", 0AH, 0H   	; Formato para número par
    fmt_impar db "O número %d é ímpar.", 0AH, 0H  	; Formato para número ímpar

section .bss

section .text

main:
    ; Carrega o valor de num
    mov eax, [num]       ; Carrega o valor de num em eax

    ; Verifica se o número é par ou ímpar
    test eax, 1          ; Testa o bit menos significativo
    jz par_num		  ; Se o bit menos significativo é 0, é par

    ; Número ímpar
    push eax             ; Empilha o número para printf
    push fmt_impar       ; Empilha a string de formato para printf
    call printf          ; Chama printf
    add esp, 8           ; Limpa a pilha
    jmp fim_programa     ; Pula para o final do programa

par_num:
    ; Número par
    push eax             ; Empilha o número para printf
    push fmt_par        ; Empilha a string de formato para printf
    call printf          ; Chama printf
    add esp, 8           ; Limpa a pilha

fim_programa:
    ; Finaliza o programa
    mov eax, 1           ; syscall number for sys_exit
    xor ebx, ebx         ; exit status 0
    int 0x80             ; chamada de sistema

