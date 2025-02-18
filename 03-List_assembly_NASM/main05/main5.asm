extern printf
global main

section .data
    msg_fmt db "%d", 0AH, 0

section .bss
    num resd 1

section .text

main:
    ; Inicializa o número inicial com 1000
    mov eax, 1000
    mov [num], eax

loop_inicio:
    ; Carrega o valor de num para eax
    mov eax, [num]

    ; Verifica se o número atual é maior que 1999
    cmp eax, 1999
    jg loop_fim

    ; Divide eax por 11
    mov edx, 0          ; Limpa o registrador edx para a divisão
    mov ebx, 11
    div ebx             ; edx:eax / ebx -> eax = quociente, edx = resto

    ; Verifica se o resto é 5
    cmp edx, 5
    jne incrementa_num   ; Se o resto não for 5, incrementa o número

    ; Exibe o número atual
    mov eax, [num]
    push eax
    push msg_fmt
    call printf
    add esp, 8

incrementa_num:
    ; Incrementa o número
    mov eax, [num]
    inc eax
    mov [num], eax
    jmp loop_inicio

loop_fim:
    ; Finaliza o programa
    mov eax, 1          
    xor ebx, ebx        ; exit status 0
    int 0x80            ; chamada de sistema

