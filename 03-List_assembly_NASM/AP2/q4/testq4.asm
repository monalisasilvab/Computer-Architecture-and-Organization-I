extern printf, scanf, soma_inteiros
global main

section .data
    	entrada db "Digite um numero inteiro positivo: ", 0H
    	format db "%d", 0H
    	saida db "Soma dos inteiros de 1 ate %d eh %d", 0AH, 0H

section .bss
	n resd 1                

section .text

main:
    	push dword entrada       
    	call printf             
    	add esp, 4            

    
   	push dword n            
    	push dword format       
    	call scanf              
    	add esp, 8             

   
    	mov eax, [n]            
    	call soma_inteiros      


    	push dword eax          
    	push dword [n]          
    	push dword saida       
    	call printf           
    	add esp, 12          

    
    	mov eax, 1              
    	xor ebx, ebx          
    	int 0x80           
