global calculo_shrd:function
extern printf

section .bss
	a_shrd resd 1

section .data
	i       dd 0               	
    	limite  dd 3               	
    	v_shrd_eax  dd 0x00E0      
    	v_shrd_ebx  dd 0x009D      	
	saida_ant_shrd db "valor antigo shrd: %d",0AH,0H
	saida_nov_shrd db "valor novo shrd 0x%08X: 0x%08X",0AH,0H

section .text

calculo_shrd:
	mov eax, [v_shrd_eax]            	
    	mov [a_shrd], eax            	
	push DWORD [a_shrd]          	
	push saida_ant_shrd          	
	call printf                  	
	add esp, 8                  	

    	mov ebx, [i]                 	
laco_shrd:
    	cmp ebx, [limite]            	
    	jae next_shrd                	
    	inc ebx                      	

    	mov eax, [a_shrd]            	
    	mov ebx, [v_shrd_ebx]            	
    	shrd eax, edx, 1             	
    	mov [a_shrd], eax            	

    	push DWORD [a_shrd]          	
    	push ebx                     
    	push DWORD [v_shrd_eax]          	
    	push saida_nov_shrd         
    	call printf                  
    	add esp, 16                  

    	jmp laco_shrd                

next_shrd:
    	ret                          
