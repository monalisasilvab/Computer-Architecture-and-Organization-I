global main5:function
extern printf

section .data
	par_saida db "par=%d", 0AH, 0H
	impar_saida db "impar=%d", 0AH, 0H
	
section .text
par:
	push ebp
	mov ebp, esp
	
	mov eax, [ebp + 8]
	and eax, 1
	
	mov esp, ebp
	pop ebp
	ret

main5:
	push ebp
	mov ebp, esp
	
	sub esp, 4
	
	push 11
	call par
	add esp, 4
	mov [ebp - 4], eax
	
	cmp DWORD [ebp - 4], 0
	jne impar
	
	push DWORD [ebp - 4]
	push par_saida
	call printf
	add esp, 8
	jmp final
	
impar:
	push DWORD [ebp - 4]
	push impar_saida
	call printf
	add esp, 8
	
final:	
	mov esp, ebp
	pop ebp
	ret
