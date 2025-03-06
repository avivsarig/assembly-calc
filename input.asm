global input
extern print

section .data
    prompt db "What would you like to calculate?", 10
    promptLen equ $-prompt

section .bss
    inputBuffer resb 100

section .text
input:
    ; print prompt
    mov rdi, prompt
    mov rsi, promptLen
    call print

    ; get input
    mov rax, 0
    mov rdi, 0
    mov rsi, inputBuffer
    mov rdx, 100
    syscall
    
    mov rdx, rax
    mov rax, inputBuffer

    ret