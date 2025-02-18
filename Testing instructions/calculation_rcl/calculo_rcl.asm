global calculo_rcl:function
extern printf

section .bss
	a_rcl resd 1

section .data
	i_rcl dd 0
	limite_rcl dd 3
	v_rcl dd 5
	saida_ant_rcl db "valor antigo rlc: %u", 0AH, 0H
	saida_nov_rcl db "valor novo rcl %u x (2^%d): %u", 0AH, 0H

section .text

calculo_rcl:
	mov eax, [v_rcl]
	mov [a_rcl], eax
	push DWORD [a_rcl]
	push saida_ant_rcl
	call printf
	add esp, 8
	
	mov ebx, [i_rcl]
	clc

laco_rcl:
	cmp ebx, [limite_rcl]
	jae next_rcl
	inc ebx
	mov eax, [a_rcl]
	rcl eax, 1
	mov [a_rcl], eax
	push DWORD [a_rcl]
	push ebx
	push DWORD [v_rcl]
	push saida_nov_rcl
	call printf
	add esp, 16
	
	jmp laco_rcl

next_rcl:
	ret
