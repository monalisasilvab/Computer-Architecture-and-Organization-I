extern printf
global main

section .data
    	array dd 10, 20, 30, 40     ; Array de 32-bit (4 elementos)
	msg_original db "Array original: %d %d %d %d", 0AH, 0H
    	msg_rotacionado db "Array rotacionado: %d %d %d %d", 0AH, 0H

section .bss
    temp resd 1                 

section .text
main:
	mov eax, [array]         
    	mov ebx, [array + 4]       
    	mov ecx, [array + 8]      
    	mov edx, [array + 12]   
    	push edx                   
    	push ecx
    	push ebx
    	push eax
    	push msg_original         
    	call printf
    	add esp, 20              

    	mov eax, [array + 12]      
    	mov [temp], eax           

    	mov eax, [array + 8]      
    	mov [array + 12], eax      
    	mov eax, [array + 4]      
    	mov [array + 8], eax       
    	mov eax, [array]           
    	mov [array + 4], eax       
    	mov eax, [temp]            
    	mov [array], eax          

    
    	mov eax, [array]           
    	mov ebx, [array + 4]       
    	mov ecx, [array + 8]      
    	mov edx, [array + 12]     
    	push edx                   
    	push ecx
    	push ebx
    	push eax
    	push msg_rotacionado          
    	call printf
    	add esp, 20                

   
    	mov eax, 1                 
    	xor ebx, ebx               
    
    	int 0x80                   

