global main
extern printf

section .data
    fmt_par db "A soma dos numeros pares de 1 ate 100 eh: %d", 0AH, 0H
    fmt_impar db "A soma dos numeros impares de 1 ate 100 eh: %d", 0AH, 0H

section .bss
    soma_par resd 1
    soma_impar resd 1

section .text
main:
    ; Inicializa as variáveis
    xor eax, eax        ; soma dos numeros pares
    xor ebx, ebx        ; soma dos numeros ímpares
    mov ecx, 1          ; contador

soma_loop:
    ; Verifica se o contador é par
    mov edx, ecx
    and edx, 1
    jz par_num

impar_num:
    add ebx, ecx        ; soma ímpar
    jmp prox_iteracao

par_num:
    add eax, ecx        ; soma par

prox_iteracao:
    inc ecx             ; incrementa o contador
    cmp ecx, 101        ; verifica se o contador chegou a 101
    jl soma_loop

    ; Armazena as somas em variáveis
    mov [soma_par], eax
    mov [soma_impar], ebx

    ; Exibe a soma dos pares
    push dword [soma_par]
    push dword fmt_par
    call printf
    add esp, 8

    ; Exibe a soma dos ímpares
    push dword [soma_impar]
    push dword fmt_impar
    call printf
    add esp, 8

    ; Finaliza o programa
    mov eax, 1          ; syscall number for sys_exit
    xor ebx, ebx        ; exit status 0
    int 0x80            ; chamada de sistema

