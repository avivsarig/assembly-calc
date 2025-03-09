global parse
extern print

section .data
    errMessage db "Sorry, I couldn't parse that. please enter 2 numbers seperated by mathmatical operator", 10
    errMessageLen equ $-errMessage

section .text
parse:
    cmp rsi, 3
    jl error
    
    xor rcx, rcx            ; loop index
    xor r10, r10            ; sum variable

first_loop:
    cmp rcx, rsi            ; compare index with length
    jge error
    mov al, [rdi + rcx]     ; get char
    
    ; is it a digit?
    cmp al, '0'
    jl check_operator
    cmp al, '9'
    jg check_operator

    ; it's a digit
    sub al, '0'             ; convert from ASCII to int
    imul r10, r10, 10
    movzx r11, al           ; mov al to r11, fills upper bits with zeros
    add r10, r11
    jmp cont_first_loop

cont_first_loop:
    inc rcx
    jmp first_loop

check_operator:
    cmp al, '+'
    je operator_found
    cmp al, '-'
    je operator_found
    cmp al, '*'
    je operator_found
    cmp al, '/'
    je operator_found

    jmp error
   
operator_found:
    mov r8b, al              ; save operator
    mov rdx, r10            ; save first number
    xor rcx, rcx            ; reset index
    xor r10, r10            ; reset sum

second_loop:
    cmp rcx, rsi            ; compare index with length
    jge done
    mov al, [rdi + rcx]     ; get char
    
    cmp al, '0'
    jl error
    cmp al, '9'
    jg error

    sub al, '0'             ; convert from ASCII to int
    imul r10, r10, 10
    movzx r11, al           ; mov al to r11, fills upper bits with zeros
    add r10, r11

    jmp second_loop

done:
    mov rcx, r10            ; save second number
    mov rax, 1              ; return sucessful parsing
    ret
    ; rax - is parsing sucessful
    ; rdx - first number
    ; rcx - second number
    ; r8 - operator

error:
    mov rdi, errMessage
    mov rsi, errMessageLen
    call print

    mov rax, 0
    ret