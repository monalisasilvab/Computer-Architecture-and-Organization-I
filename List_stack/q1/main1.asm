global main1:function
extern printf

section .data
	fmt db "a=%d, eax=%d", 0AH, 0H 

section .bss

section .text
main1:
	push ebp             
	mov ebp, esp         

	sub esp, 4           
	mov dword [ebp-4], 5 

	mov eax, [ebp-4]    
	push eax             
	    
	add eax, 2           
	push eax             
	    
	mov eax, [ebp-4]     
	push eax             
	    
	push fmt             

	call printf         
	add esp, 16          

	mov esp, ebp         
	pop ebp              
	ret                  
