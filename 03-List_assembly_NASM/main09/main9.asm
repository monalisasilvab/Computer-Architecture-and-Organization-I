extern printf, scanf
global main

section .data
    nota1 dw 0           ; Primeira nota (inicializada com 0)
    nota2 dw 0           ; Segunda nota (inicializada com 0)
    nota3 dw 0           ; Terceira nota (inicializada com 0)
    
    fmt_input db "Insira a nota %d: ", 0
    fmt_scan db "%d", 0
    fmt_aprovado db "Aluno Aprovado", 0AH, 0H
    fmt_aval_final db "Aluno em Avaliacao Final", 0AH, 0H
    fmt_reprovado db "Aluno Reprovado", 0AH, 0H
    divisor dw 6         ; Divisor para a média ponderada (1+2+3)

section .bss
    media resd 1         ; Variável para armazenar a média

section .text

main:
    ; Primeira nota do usuário
    push 1
    push fmt_input
    call printf
    add esp, 8
    push nota1
    push fmt_scan
    call scanf
    add esp, 8

    ; Segunda nota do usuário
    push 2
    push fmt_input
    call printf
    add esp, 8
    push nota2
    push fmt_scan
    call scanf
    add esp, 8

    ; Terceira nota do usuário
    push 3
    push fmt_input
    call printf
    add esp, 8
    push nota3
    push fmt_scan
    call scanf
    add esp, 8

    ; Calcula a média ponderada ((nota1 * 1) + (nota2 * 2) + (nota3 * 3)) / 6
    mov ax, [nota1]
    imul ax, 1           ; Multiplica nota1 por 1
    mov bx, ax           ; Armazena o resultado em bx

    mov ax, [nota2]
    imul ax, 2           ; Multiplica nota2 por 2
    add bx, ax           ; Soma o resultado anterior com bx

    mov ax, [nota3]
    imul ax, 3           ; Multiplica nota3 por 3
    add bx, ax           ; Soma o resultado anterior com bx

    mov ax, bx
    cwd                  ; Estende o sinal de ax para dx:ax
    idiv word [divisor]  ; Divide dx:ax por divisor (6)
    mov [media], ax      ; Armazena o resultado em media

    ; Verifica a situação do aluno
    mov ax, [media]
    cmp ax, 7
    jge aprovado         ; Se media >= 7, aluno aprovado
    cmp ax, 4
    jge aval_final       ; Se 4 <= media < 7, aluno em avaliação final
    jmp reprovado        ; Se media < 4, aluno reprovado

aprovado:
    push fmt_aprovado
    call printf
    add esp, 4
    jmp fim

aval_final:
    push fmt_aval_final
    call printf
    add esp, 4
    jmp fim

reprovado:
    push fmt_reprovado
    call printf
    add esp, 4

fim:
    ; Finaliza o programa
    mov eax, 1           ; syscall number for sys_exit
    xor ebx, ebx         ; exit status 0
    int 0x80             ; chamada de sistema

