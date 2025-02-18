global soma

section .text
    
; int soma(int a, int size)
; a: [ebp+8], size: [ebp+12]
soma:
	push ebp               
    	mov ebp, esp            
    	sub esp, 4              
    
    	mov dword [ebp-4], 0    
    
    	mov ecx, [ebp+12]       
    	mov eax, [ebp+8]       
    
.loop:
    	test ecx, ecx          
    	jz .fim                
    
    	add dword [ebp-4], eax  
    	inc eax                 
    	dec ecx                 
    	jmp .loop               
	
.fim:
    	mov eax, [ebp-4]        
    	mov esp, ebp            
    	pop ebp                 
    	ret

