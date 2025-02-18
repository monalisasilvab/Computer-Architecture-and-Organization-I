section .data
    msg db 'Enter an integer: ', 0
    output_msg db 'The entered number was: ', 0
    newline db 10, 0       ; Adicionei um caractere nulo extra para garantir que a string termine corretamente

section .bss
    input resb 10          ; Buffer to store user input
    output resb 10         ; Buffer to store formatted output

section .text
    global _start

_start:
    ; Print the message asking for an integer
    mov eax, 4              ; syscall number for sys_write
    mov ebx, 1              ; file descriptor 1 (stdout)
    mov ecx, msg            ; message to be written
    mov edx, 19             ; message length
    int 0x80                ; invoke syscall

    ; Read user input
    mov eax, 3              ; syscall number for sys_read
    mov ebx, 0              ; file descriptor 0 (stdin)
    mov ecx, input          ; buffer to store input
    mov edx, 10             ; maximum input size
    int 0x80                ; invoke syscall

    ; Clear the output buffer
    xor esi, esi
    mov ecx, 10
    mov edi, output
    rep stosb

    ; Print the output message
    mov eax, 4              ; syscall number for sys_write
    mov ebx, 1              ; file descriptor 1 (stdout)
    mov ecx, output_msg     ; message to be written
    mov edx, 25             ; message length
    int 0x80                ; invoke syscall

    ; Convert the input to an integer and format the output
    mov esi, input          ; point to input
    mov edi, output         ; point to output buffer
    xor eax, eax            ; clear eax
    xor ebx, ebx            ; clear ebx
    xor ecx, ecx            ; clear ecx
.loop:
    movzx edx, byte [esi]  ; load the next character from input
    cmp edx, 0              ; check if end of string
    je .done
    sub edx, '0'            ; convert ASCII character to integer
    imul eax, eax, 10       ; multiply eax by 10
    add eax, edx            ; add the digit to the result
    inc esi                 ; move to next character
    jmp .loop
.done:
    ; Convert the integer back to string
    mov ebx, 10             ; divisor
    mov ecx, 0              ; digit counter
    .digit_loop:
        mov edx, 0          ; clear edx
        div ebx             ; divide eax by 10
        add dl, '0'         ; convert digit to ASCII
        mov [edi + ecx], dl ; store the digit in output buffer
        inc ecx             ; increment digit counter
        test eax, eax       ; check if eax is zero
        jnz .digit_loop     ; if not zero, continue
    ; Reverse the output buffer
    mov esi, 0              ; starting index
    dec ecx                 ; last index
    .reverse_loop:
        cmp esi, ecx        ; check if all digits have been traversed
        jge .print_output   ; if yes, print the output
        mov al, [edi + esi] ; load the first character
        mov ah, [edi + ecx] ; load the last character
        mov [edi + ecx], al ; move the first character to the position of the last
        mov [edi + esi], ah ; move the last character to the position of the first
        inc esi             ; increment first index
        dec ecx             ; decrement last index
        jmp .reverse_loop   ; continue until all digits have been traversed
    .print_output:
    ; Print the output
    mov eax, 4              ; syscall number for sys_write
    mov ebx, 1              ; file descriptor 1 (stdout)
    mov ecx, output         ; message to be written
    mov edx, 10             ; message length
    int 0x80                ; invoke syscall

    ; Print a newline
    mov eax, 4              ; syscall number for sys_write
    mov ebx, 1              ; file descriptor 1 (stdout)
    mov ecx, newline        ; message to be written
    mov edx, 1              ; m

