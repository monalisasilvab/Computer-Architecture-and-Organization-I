global main
extern scanf
extern printf

section .data
    	msg_ano db "DIGITE O ANO EM QUE VOCE NASCEU: ", 10, 0
    	msg_idade_anos db "SUA IDADE EM ANOS EH %d !", 10, 0
    	msg_idade_meses db "SUA IDADE EM MESES EH %d !", 10, 0
    	msg_idade_dias db "SUA IDADE EM DIAS EH %d !", 10, 0
    	msg_ano_atual db "DIGITE O ANO EM QUE ESTAMOS: ", 10, 0
    	formato_ano db "%d", 0

section .bss
	ano resd 1
    	idade_ano resd 1
    	idade_meses resd 1
    	idade_dias resd 1
    	ano_atual resd 1

section .text
    
main:
    	push msg_ano
    	call printf
    	add esp, 4

    	push ano
    	push formato_ano
    	call scanf
    	add esp, 8

    	push msg_ano_atual
    	call printf
    	add esp, 4

    	push ano_atual
    	push formato_ano
    	call scanf
    	add esp, 8

    	mov eax, [ano_atual]
    	SUB eax, [ano]
    	mov [idade_ano], eax

    	xor ecx, ecx             
    	mov ebx, [idade_ano]     
    	xor eax, eax             

calcula_meses:
    	add eax, 12              
    	inc ecx                  
    	cmp ecx, ebx             
    	jl calcula_meses       
     
    	mov [idade_meses], eax 

    	xor ecx, ecx             
    	mov ebx, [idade_ano]     
    	xor eax, eax             
calcula_dias:
    	add eax, 365             
    	inc ecx                  
    	cmp ecx, ebx             
    	jl calcula_dias          
    	mov [idade_dias], eax    

    	push DWORD [idade_ano]
    	push msg_idade_anos
    	call printf
    	add esp, 8

    	push DWORD [idade_meses]
    	push msg_idade_meses
    	call printf
    	add esp, 8

    	push DWORD [idade_dias]
    	push msg_idade_dias
    	call printf
    	add esp, 8

    	mov eax, 1
    	mov ebx, 0
    	int 0x80
    	
