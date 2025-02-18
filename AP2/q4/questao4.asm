section .text
global soma_inteiros

;---------------------------------------------------------
; PROC:
; Calcula e retorna a soma dos inteiros de 32-bit de 1 até N.
; Receives: EAX o valor de N. Sem sinal.
; Returns: EAX = soma, e as flags de status (Carry, Overflow, etc.) são modificadas.
; Requires: nada
;---------------------------------------------------------

soma_inteiros:
	push ebp                
    	mov ebp, esp            
    
    	mov ecx, eax            
    	mov eax, 0             
    	mov edx, 1              

.loop:
    	add eax, edx            
    	inc edx                 
    	cmp edx, ecx            
    	jle .loop               

    	mov esp, ebp           
    	pop ebp                 
    	ret                     

