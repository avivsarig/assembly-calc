section .text
global _start
extern input, print

_start:
    ; wait for user input
    call input
    ; parse expression
    ; calc sum
    ; print
    call print
    ; quit
    mov rax, 60
    mov rdi, 0
    syscall