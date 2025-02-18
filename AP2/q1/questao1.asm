global main
extern printf, scanf

section .data
	msg1 db "Digite o numero 1: ", 0H
    	msg2 db "Digite numero 2: ", 0H
    	msg db "A soma eh: %d", 0AH, 0H 
    	fmt db "%d", 0H                   

section .bss
    	num1 resd 1   ; Espaço para o número 1 (inteiro de 4 bytes)
    	num2 resd 1   ; Espaço para o número 2 (inteiro de 4 bytes)
    	res resd 1    ; Espaço para o resultado (inteiro de 4 bytes)

section .text
main:
    
    	mov eax, 4
    	mov ebx, 1
    	mov ecx, msg1
    	mov edx, 14
    	int 0x80

    
    	push num1       
    	push fmt         
    	call scanf       
    	add esp, 8       

    
   	mov eax, 4
    	mov ebx, 1
    	mov ecx, msg2
    	mov edx, 14
    	int 0x80

   
    	push num2       
    	push fmt        
    	call scanf       
    	add esp, 8       

    
    	mov eax, [num1]  
    	add eax, [num2]  
    	mov [res], eax   

   
    	push dword [res] 
    	push msg         
    	call printf      
    	add esp, 8       

  
    	mov eax, 1       
    	xor ebx, ebx   
    	int 0x80         

