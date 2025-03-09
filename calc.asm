global calc

section .text
calc:
    cmp rsi, '+'
    je addition
    cmp rsi, '-'
    je subtract
    cmp rsi, '*'
    je multi
    cmp rsi, '/'
    je divide

addition:
    add rax, rdi
    ret

subtract:
    sub rax, rdi
    ret

multi:
    imul rax, rdi
    ret

divide:
    cmp rdi, 0
    je division_by_zero

    cqo
    idiv rdi
    ret

division_by_zero:
    xor rax, rax
    ret