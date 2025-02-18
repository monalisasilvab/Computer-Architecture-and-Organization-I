global main
extern printf
extern scanf

section .data
	msg_lado1 db "Digite o primeiro lado do triangulo: ", 0
    	msg_lado2 db "Digite o segundo lado do triangulo: ", 0
    	msg_lado3 db "Digite o terceiro lado do triangulo: ", 0
    	formato_entrada db "%d", 0
    	msg_nao_triangulo db "Os lados nao formam um triangulo.", 10, 0
    	msg_equilatero db "Triangulo equilatero.", 10, 0
    	msg_isosceles db "Triangulo isosceles.", 10, 0
    	msg_escaleno db "Triangulo escaleno.", 10, 0

section .bss
    	lado1 resd 1
    	lado2 resd 1
    	lado3 resd 1

section .text
    
main:
    	push msg_lado1
    	call printf
    	add esp, 4
    	push lado1
    	push formato_entrada
    	call scanf
    	add esp, 8

    	push msg_lado2
    	call printf
    	add esp, 4
    	push lado2
    	push formato_entrada
    	call scanf
    	add esp, 8

    	push msg_lado3
    	call printf
    	add esp, 4
    	push lado3
    	push formato_entrada
    	call scanf
    	add esp, 8

    	mov eax, [lado1]
    	mov ebx, [lado2]
    	mov ecx, [lado3]

   
    	mov edx, ebx
    	add edx, ecx
    	cmp eax, edx
    	jg nao_triangulo

   
    	mov edx, eax
    	add edx, ecx
    	cmp ebx, edx
    	jg nao_triangulo

    
    	mov edx, eax
    	add edx, ebx
    	cmp ecx, edx
    	jg nao_triangulo

    	cmp eax, ebx
    	JNE verifica_isosceles
    	cmp eax, ecx
    	JNE verifica_isosceles

    	push msg_equilatero
    	call printf
    	add esp, 4
    	jmp fim

verifica_isosceles:
    	cmp eax, ebx
    	je imprime_isosceles
    	cmp eax, ecx
    	je imprime_isosceles
    	cmp ebx, ecx
    	je imprime_isosceles

    	push msg_escaleno
    	call printf
    	add esp, 4
    	jmp fim

imprime_isosceles:
    
    	push msg_isosceles
    	call printf
    	add esp, 4
    	jmp fim

nao_triangulo:
    	push msg_nao_triangulo
    	call printf
    	add esp, 4

fim:
    	mov eax, 1
    	mov ebx, 0
    	int 0x80
    	
    	
