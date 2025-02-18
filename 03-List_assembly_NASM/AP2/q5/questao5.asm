global main

section .data
	msgBarato db "Classificacao: Barato", 0
    	msgNormal db "Classificacao: Normal", 0
    	msgCaro db "Classificacao: Caro", 0
    	msgMuitoCaro db "Classificacao: Muito Caro", 0
    	msgPreco db "Digite o preco do produto: ", 0

section .bss
    	preco resb 10   
    	valor resd 1    

section .text

main:
    
    	mov eax, 4          
    	mov ebx, 1          
    	mov ecx, msgPreco   
    	mov edx, 27         
    	int 0x80            

    	mov eax, 3          
    	mov ebx, 0          
    	mov ecx, preco      
    	mov edx, 10        
    	int 0x80            

    
    	call string_to_int

  
    	mov eax, [valor]    

    
    	cmp eax, 80
    	jle barato          

    	cmp eax, 120
    	jle normal        

    	cmp eax, 200
    	jle caro         

    	jmp muito_caro

barato:
    	mov eax, 4
    	mov ebx, 1
    	mov ecx, msgBarato
    	mov edx, 21         
    	int 0x80
    	jmp fim

normal:
    	mov eax, 4
    	mov ebx, 1
    	mov ecx, msgNormal
    	mov edx, 21         
    	int 0x80
    	jmp fim

caro:
    	mov eax, 4
    	mov ebx, 1
    	mov ecx, msgCaro
    	mov edx, 19         
    	int 0x80
    	jmp fim

muito_caro:
    	mov eax, 4
    	mov ebx, 1
    	mov ecx, msgMuitoCaro
    	mov edx, 26         
    	int 0x80

fim:
    
    	mov eax, 1
    	xor ebx, ebx
    	int 0x80


string_to_int:
    	xor eax, eax       
    	xor ebx, ebx       

    mov esi, preco    
convert_loop:
    mov al, [esi]      
    cmp al, 0xA          
    je end_convert      

    sub al, '0'         
    imul ebx, ebx, 10   
    add ebx, eax        
    inc esi             
    jmp convert_loop

end_convert:
    mov [valor], ebx    
    ret
