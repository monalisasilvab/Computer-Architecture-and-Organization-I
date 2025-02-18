global main3:function
extern printf

section .data
	saida db "soma eh: %d", 0AH, 0H

section .text
funcao:
	push ebp 
	mov ebp, esp
	
	sub esp, 12
	mov DWORD [ebp - 4], 5
	mov DWORD [ebp - 8], 2
	
	mov eax, [ebp - 4]
	add eax, [ebp - 8]
	mov DWORD [ebp - 12], eax
	
	push DWORD [ebp - 12]
	push saida
	call printf
	add esp, 8
	
	mov esp, ebp
	pop ebp
	ret

main3:
	push ebp
	mov ebp, esp
	
	call funcao
	
	mov esp, ebp
	pop ebp
	ret
