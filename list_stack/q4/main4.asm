global main4:function
extern printf

section .data
	fmt db "soma eh: %d", 0AH, 0H  

section .text

; funcao: int funcao(int x, int y)
funcao:
	push ebp
	mov ebp, esp

	sub esp, 8               

    	mov eax, [ebp + 8]       
    	mov dword [ebp - 4], eax 

    	mov eax, [ebp + 12]      
    	mov dword [ebp - 8], eax 

    	mov eax, [ebp - 4]       
    	add eax, [ebp - 8]       
    
    	mov esp, ebp
    	pop ebp
    	ret                      


main4:
    	push ebp
    	mov ebp, esp
    
    	sub esp, 4               
    	push 3                   
    	push 2                   
    	call funcao             
    	add esp, 8               
    	mov [ebp - 4], eax       

    	push dword [ebp - 4]     
    	push fmt                 
    	call printf              
   	add esp, 8               
    
   	 mov esp, ebp
    	pop ebp
    	ret                     

