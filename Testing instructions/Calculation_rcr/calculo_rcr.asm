global calculo_rcr:function
extern printf

section .bss
    	a_rcr resd 1  

section .data
	i_rcr   dd 0         
    	limite_rcr dd 3       
    	v_rcr   dd 40         
    	saida_ant_rcr db "valor antigo rcr: %u", 0AH, 0H
    	saida_nov_rcr db "valor novo rcr %u x (2^%d): %u", 0AH, 0H

section .text

calculo_rcr:
    	mov eax, [v_rcr]         
    	mov [a_rcr], eax         
    	push DWORD [a_rcr]       
    	push saida_ant_rcr       
    	call printf              
    	add esp, 8              

    	mov ebx, [i_rcr]         
    	clc                     

laco_rcr:
    	cmp ebx, [limite_rcr]    
    	jae next_rcr             
    	inc ebx                  
    	mov eax, [a_rcr]         
    	rcr eax, 1               
    	mov [a_rcr], eax         

    	push DWORD [a_rcr]      
    	push ebx                 
    	push DWORD [v_rcr]       
    	push saida_nov_rcr       
    	call printf              
    	add esp, 16              

    	jmp laco_rcr             

next_rcr:
    	ret                      

