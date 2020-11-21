;Find the 10,001st prime number
                    section .data

                    section .bss

                    section .text
                    global _start
_start:
                    
                    mov rcx, 1
                    mov r10, 1                      ;prime counter
    .main_loop:
                    add rcx, 2
                    mov rdi, rcx
                    push rcx
                    call is_prime                   ;check if prime
                    pop rcx
                    cmp rax, 1
                    jne .main_loop
                    inc r10                         ;if prime, inc counter
                    mov r8, rcx
                    cmp r10, 10001
                    je .end_program
                    jmp .main_loop

    .end_program:
                    mov rax, 60
                    xor rdi, rdi
                    syscall
                    


is_prime:
                    mov r9, rdi
                    mov rax, rdi

                    cmp rax, 1                      ;if 1, ret false
                    jle .prime_false

                    cmp rax, 2
                    je .prime_true                  ;if 2, ret true
                    mov rbx, 2

                    xor rdx, rdx
                    div rbx                         ;if even, ret false
                    cmp rdx, 0
                    je .prime_false

                    mov rcx, 3                      ;i = 3
    .loop_start:                    
                    mov rax, r9                     ;rax will be kill by div
                    mov rdx, rcx                    ;while i**2 < n
                    imul rdx, rcx
                    cmp rdx, rax
                    jg .prime_true                  ;if end reached, prime
                    mov rbx, rcx
                    xor rdx, rdx
                    div rbx
                    cmp rdx, 0
                    je .prime_false                 ;divisor found, ret false
                    inc rcx
                    mov rax, r9
                    jmp .loop_start
    .prime_true:
                    mov rax, 1
                    ret
    .prime_false:
                    mov rax, 0
                    ret
