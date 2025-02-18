global calculo_shld:function
extern printf

section .bss
	a_shld resd 1

section .data
	i      dd 0
	limite dd 3
	v_shld_eax  dd 0x00E0
	v_shld_ebx  dd 0x009D
	saida_ant_shld db "valor antigo shld: %d",0AH,0H
	saida_nov_shld db "valor novo shld 0x%08X: 0x%08X",0AH,0H

section .text

calculo_shld:
	mov eax, [v_shld_eax]
	mov [a_shld], eax	
	push DWORD [a_shld]
	push saida_ant_shld
	call printf	
	add esp, 8
	
	mov ebx, [i]	
laco_shld:
	cmp ebx, [limite]
	jae next_shld
	inc ebx
	mov eax, [a_shld]
	mov ebx, [v_shld_ebx]		
	shld eax, ebx, 1	
	mov [a_shld], eax
	push DWORD [a_shld]
	push ebx
	push DWORD [v_shld_eax]
	push saida_nov_shld
	call printf	
	add esp, 16
	
	jmp laco_shld
	
next_shld:
	ret
