; Hello World 32 bits

section .data
    msg db 'Hello, World!', 0x0a  ; 0x0a =>  new line ('\n')
    len equ $ - msg                ; message length

section .text
    global _start

_start:
    ; Write the message to stdout
    mov eax, 4            ; syscall number 4: sys_write
    mov ebx, 1            ; file descriptor 1: stdout
    mov ecx, msg          ; pointer to message
    mov edx, len          ; message length
    int 0x80              ; call the system

    ; End the program
    mov eax, 1            ; syscall número 1: sys_exit
    xor ebx, ebx          ; exit code 0
    int 0x80              ; call the system
