extern printf, scanf
global main

section .data
    fmt_in db "%d", 0
    fmt_out db "O valor de a é: %d", 0AH, 0H
    prompt_b db "Digite o valor de b: ", 0
    prompt_c db "Digite o valor de c: ", 0
    b dd 0
    c dd 0
    a dd 0

section .bss

section .text

main:
    ; Prompt para b
    push prompt_b
    call printf
    add esp, 4

    ; Leitura do valor de b
    push b
    push fmt_in
    call scanf
    add esp, 8

    ; Prompt para c
    push prompt_c
    call printf
    add esp, 4

    ; Leitura do valor de c
    push c
    push fmt_in
    call scanf
    add esp, 8

    ; Carrega os valores de b e c
    mov eax, [b]        ; eax = b
    mov ebx, [c]        ; ebx = c

    ; Calcula 2 * b
    shl eax, 1          ; eax = 2 * b

    ; Calcula c / 2
    shr ebx, 1          ; ebx = c / 2

    ; Soma os resultados parciais
    add eax, ebx        ; eax = (2 * b) + (c / 2)

    ; Adiciona 200
    add eax, 200        ; eax = (2 * b) + (c / 2) + 200

    ; Armazena o resultado em a
    mov [a], eax        ; a = eax

    ; Exibe o resultado
    push eax
    push fmt_out
    call printf
    add esp, 8

    ; Finaliza o programa
    mov eax, 1          ; syscall number for sys_exit
    xor ebx, ebx        ; exit status 0
    int 0x80            ; chamada de sistema

