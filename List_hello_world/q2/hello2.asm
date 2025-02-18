;Hello World 64 bits

section .data
    msg db 'Hello, World!', 0xa   ; Message to be displayed
    msglen equ $ - msg            ; Message length

section .text
    global _start                 ; Program entry

_start:
    ; syscall write
    mov rax, 1                   ; syscall number for sys_write
    mov rdi, 1                   ; file descriptor 1 (stdout)
    mov rsi, msg                 ; pointer to the message
    mov rdx, msglen              ; message length
    syscall                      ; make syscall

    ; syscall exit
    mov rax, 60                  ; syscall number for sys_exit
    xor rdi, rdi                 ; return 0 status
    syscall                      ; make syscall

