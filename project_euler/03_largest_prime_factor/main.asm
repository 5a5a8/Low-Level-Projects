;Find the largest prime factor of 600851475143
;This code needs serious work, but I'm here to learn x86_64, not maths
;It took about 10 minutes to run
                    section .data
            target: dq 600851475143 

                    section .bss

                    section .text
                    global _start
_start:
                    mov r10, 1                      ;i = 1
                    mov r11, qword [target]
    .loop_start:
                    add r10, 2                      ;while 3*i < target
                    mov r12, r10
                    imul r12, 3
                    cmp r12, r11
                    jge .end_program

                    mov rdi, r10                    ;is_factor(i)
                    call is_factor
                    cmp rax, 0
                    je .loop_start

                    mov rdi, r10                    ;is_prime(i)
                    call is_prime
                    cmp rax, 0
                    je .loop_start

                    mov r8, r10                     ;if isfactor AND
                    jmp .loop_start                 ;isprime, largest = i
    .end_program:
                    mov rax, 60                     ;exit
                    xor rdi, rdi                    ;result in r8
                    syscall
                    




is_factor:
                    mov rax, rdi

                    mov rbx, rax                    ;divisor in rbx
                    mov rax, qword [target]         ;dividend in rax
                    xor rdx, rdx
                    div rbx
                    cmp rdx, 0
                    jne factor_false                ;if not factor return 0
                    mov rax, 1                      ;return 1 if factor
                    ret
    factor_false:
                    mov rax, 0
                    ret

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

