section .data
    mensagem1 db "Digite o 1° numero: ", 0

    mensagem2 db "Digite o 2° numero: ", 0

    mensagem3 db "Escolha a operacao: ", 0

    mensagem4 db "1. Somar", 10, "2. Subtrair", 10, "3. Multiplicar", 10, "4 - Dividir", 10, "0. Sair", 10, 0

    mensagem5 db "Resultado: %d", 10, 0

    mensagem6 db "Deseja fazer uma nova conta? (1. Sim, 0. Sair): ", 0

    mensagem_invalida db "Opcao invalida. Tente novamente.", 10, 0

    number_format db "%d", 0

section .bss
    number1 resd 1
    number2 resd 1
    resultado resd 1
    operacao resb 1
    escolha resb 1

section .text
    extern printf, scanf
    global _start

_start:
main_loop:
    push mensagem1
    call printf
    add esp, 4
    push number1
    push number_format
    call scanf
    add esp, 8

    push mensagem2
    call printf
    add esp, 4
    push number2
    push number_format
    call scanf
    add esp, 8

operacao_loop:
    push mensagem3
    call printf
    add esp, 4
    push mensagem4
    call printf
    add esp, 4
    push operacao
    call scanf
    add esp, 4

    cmp byte [operacao], '1'
    je add_numbers
    cmp byte [operacao], '2'
    je sub_numbers
    cmp byte [operacao], '3'
    je mul_numbers
    cmp byte [operacao], '4'
    je div_numbers
    cmp byte [operacao], '0'
    je exit_calculator

    push mensagem_invalida
    call printf
    add esp, 4
    jmp operacao_loop

add_numbers:
    mov eax, [number1]
    add eax, [number2]
    mov [resultado], eax
    jmp print_resultado

sub_numbers:
    mov eax, [number1]
    sub eax, [number2]
    mov [resultado], eax
    jmp print_resultado

mul_numbers:
    mov eax, [number1]
    imul eax, [number2]
    mov [resultado], eax
    jmp print_resultado

div_numbers:
    mov eax, [number1]
    xor edx, edx
    mov ebx, [number2]
    cmp ebx, 0
    je div_por_zero
    div ebx
    mov [resultado], eax
    jmp print_resultado

div_por_zero:
    push mensagem_invalida

exit_calculator:
    mov eax, 1
    xor ebx, ebx
    int 0x80
