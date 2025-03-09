section .text
global _start
extern input, print, calc, parse

_start:
    ; wait for user input
    call input
    ; parse expression
    mov rdi, rdx ; rdi = input
    mov rsi, rax ; rsi = input len

    call parse
    cmp rax, 1 ; is successful parsing?
    jl _start

    ; calc sum
    mov rax, rdx ; RAX - first num
    mov rdi, rcx ; RDI - second num
    mov rsi, r8 ; rsi - operator
    call calc

    call res_to_int
    ; print
    call print

    ; quit
    mov rax, 60
    mov rdi, 0
    syscall
    
; args - rdi, rsi
; returns - rdx, rax