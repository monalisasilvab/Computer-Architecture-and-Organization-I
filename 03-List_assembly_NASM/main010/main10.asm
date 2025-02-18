extern printf, scanf
global main

section .data
    msg_input db "Digite a media final do aluno: ", 0AH, 0
    fmt_input db "%d", 0
    msg_invalid db "Voce digitou numero invalido", 0AH, 0
    msg_aprovado db "APROVADO!", 0AH, 0
    msg_reprovado db "REPROVADO!", 0AH, 0
    msg_fim db "Fim do programa!", 0AH, 0

section .bss
    media resd 1

section .text

main:
    ; Inicializa a variável media com 0
    mov dword [media], 0

loop_inicio:
    ; Exibe a mensagem de entrada
    push msg_input
    call printf
    add esp, 4

    ; Lê a média do usuário
    push media
    push fmt_input
    call scanf
    add esp, 8

    ; Carrega o valor de media para eax
    mov eax, [media]

    ; Verifica se a media é -1
    cmp eax, -1
    je fim

    ; Verifica se a media é menor que -1 ou maior que 10
    cmp eax, -1
    jl entrada_invalida
    cmp eax, 10
    jg entrada_invalida

    ; Verifica se a media é maior ou igual a 7
    cmp eax, 7
    jge aprovado
    jmp reprovado

entrada_invalida:
    ; Exibe mensagem de número inválido
    push msg_invalid
    call printf
    add esp, 4
    jmp loop_inicio

aprovado:
    ; Exibe mensagem de aprovado
    push msg_aprovado
    call printf
    add esp, 4
    jmp loop_inicio

reprovado:
    ; Exibe mensagem de reprovado
    push msg_reprovado
    call printf
    add esp, 4
    jmp loop_inicio

fim:
    ; Exibe mensagem de fim do programa
    push msg_fim
    call printf
    add esp, 4

    ; Finaliza o programa
    mov eax, 1          ; syscall number for sys_exit
    xor ebx, ebx        ; exit status 0
    int 0x80            ; chamada de sistema

