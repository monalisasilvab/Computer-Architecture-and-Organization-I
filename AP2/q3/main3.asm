extern printf, soma
global main

section .data
    msg db "soma eh: %d", 0AH, 0H

section .text

main:
    push 5                 
    push 1                 
    call soma                
    add esp, 8            

    push eax                
    push msg               
    call printf         
    add esp, 8             

    mov eax, 1              
    xor ebx, ebx            
    int 0x80                

