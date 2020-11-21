;Difference between sum(squares) and square(sum) first 100 natural numbers
                    section .data
            limit:  dq 100

                    section .bss

                    section .text
                    global _start
_start:
                    call sum_squares
                    mov r9, rax

                    call square_sum
                    mov r10, rax
                    
                    sub r10, r9

                    mov r8, r10                     ;answer in r8
    .end_program:
                    mov rax, 60
                    xor rdi, rdi
                    syscall


sum_squares:
                    xor rax, rax                    ;running sum
                    mov rcx, 1                      ;counter
    .loop_start:
                    mov rbx, rcx                    ;calculate square
                    imul rbx, rcx
                    add rax, rbx                    ;add to running sum
                    inc rcx
                    cmp rcx, qword [limit]          ;check for end of loop
                    jle .loop_start
                    ret


square_sum:
                    xor rax, rax                    ;sum to 100
                    mov rcx, 1
    .loop_start:
                    add rax, rcx
                    inc rcx
                    cmp rcx, qword [limit]
                    jle .loop_start
                    imul rax, rax                   ;square it and return
                    ret
