global main2:function
extern printf

section .data
	saida db "soma eh: %d", 0AH, 0H  ; String formatada para printf

section .bss

section .text

funcao:
	push ebp
	mov ebp, esp
	    
	sub esp, 8
	mov dword [ebp - 4], 5
	    
	mov eax, [ebp + 8]     ; Move o valor do argumento (x) para eax
	mov dword [ebp - 8], eax  ; Move o valor de eax para 'b'
	    
	mov eax, [ebp - 4]     ; Carrega 'a' em eax
	add eax, [ebp - 8]     ; Soma 'a' + 'b' e armazena o resultado em eax
	    
	mov esp, ebp
	pop ebp
	ret

main2:
	push ebp
	mov ebp, esp
	    
	sub esp, 4
	push 2
	call funcao
	add esp, 4
	mov [ebp - 4], eax
	    
	push dword [ebp - 4]
	push saida
	call printf
	add esp, 8
	    
	mov esp, ebp
	pop ebp
	ret
