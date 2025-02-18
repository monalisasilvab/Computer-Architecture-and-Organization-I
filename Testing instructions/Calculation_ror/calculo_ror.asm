global calculo_ror:function
extern printf

section .bss
	a_ror resd 1

section .data
	i_ror dd 0
	limite_ror dd 3
	v_ror dd 8
	saida_ant_ror db "valor antigo ror: %u", 0AH, 0H
	saida_nov_ror db "valor novo ror %u x (2^%d): %u", 0AH, 0H

section .text

calculo_ror:
	mov eax, [v_ror]
	mov [a_ror], eax
	push DWORD [a_ror]
	push saida_ant_ror
	call printf
	add esp, 8
	
	mov ebx, [i_ror]

laco_ror:
	cmp ebx, [limite_ror]
	jae fim_ror
	inc ebx
	mov eax, [a_ror]
	ror eax, 1
	mov [a_ror], eax
	push DWORD [a_ror]
	push ebx
	push DWORD [v_ror]
	push saida_nov_ror
	call printf
	add esp, 16
	
	jmp laco_ror

fim_ror:
	ret
