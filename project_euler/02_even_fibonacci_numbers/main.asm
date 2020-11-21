;Find the sum of even-valued fibonacci terms less than four million
                    section .data
        limit:      dq 4000000                  ;fib3 can't exceed this

                    section .bss

                    section .text
                    global _start
_start:
                    mov r8, 2                   ;running total
                    mov r11, 1                  ;fib 1
                    mov r12, 2                  ;fib2
    loop_start:
                    cmp r13, qword [limit]      ;if over the limit, end
                    jg end_program
                    mov r14, r12                ;back up fib2
                    add r12, r11                ;fib3 = fib2 + fib1
                    mov r13, r12                ;result in fib3
                    mov r11, r14                ;fib1 = fib2 (from backup)
                    mov rax, r13                ;prep function call
                    call is_even                ;check if even
                    cmp rax, 0  
                    je loop_start               ;if odd: continue
                    add r8, r13                 ;if even: add to total
                    jmp loop_start
    end_program:
                    mov r8, r13                 ;i like the answer in r8
                    mov rax, 60
                    xor rdi, rdi
                    syscall                     ;exit
                    

is_even:
                    xor rdx, rdx                ;clear rdx
                    mov rbx, 2                  ;we will divide by 2
                    div rbx                     ;rax/rbx
                    cmp rdx, 0                  ;modulo is in rdx
                    jne even_false              ;return 0 if false
                    mov rax, 1                  ;return 1 if true
                    ret
    even_false:
                    mov rax, 0
                    ret

