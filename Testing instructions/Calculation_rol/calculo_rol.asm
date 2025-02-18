global calculo_rol:function
extern printf

section .bss
	a_rol resd 1

section .data
	i_rol dd 0
	limite_rol dd 3
	v_rol dd 5
	saida_ant_rol db "valor antigo rol: %d", 0AH, 0H
	saida_nov_rol db "valor novo rol: %d x (2^%d): %d", 0AH, 0H

section .text

calculo_rol:
	mov eax, [v_rol]
	mov [a_rol], eax
	push DWORD [a_rol]
	push saida_ant_rol
	call printf
	add esp, 8
	
	mov ebx, [i_rol]

laco_rol:
	cmp ebx, [limite_rol]
	jae fim_rol
	inc ebx
	mov eax, [a_rol]
	rol eax, 1
	mov [a_rol], eax
	push DWORD [a_rol]
	push ebx
	push DWORD [v_rol]
	push saida_nov_rol
	call printf
	add esp, 16
	
	jmp laco_rol

fim_rol:
	ret
