;Smallest positive number evenly divisible by all numbers from 1 to 20
                    section .data

                    section .bss
                    
                    section .text

                    global _start
_start:
                    mov r8, 2520                ;start at 2520
    .loop_start:
                    add r8, 2520                ;we know it will be a 
                    mov rax, r8                 ;multiple of 1-10
                    call is_found
                    cmp rax, 1
                    je .end_program
                    jmp .loop_start

    .end_program:
                    mov rax, 60                 ;exit with result in r8,
                    xor rdi, rdi                ;as usual
                    syscall









is_found:
                    mov rcx, 11                 ;we only need to check 11-20
                    mov r9, rax                 ;this auto covers 1-10
                    
    .loop_start:
                    cmp rcx, 20
                    je .found                   ;if we make it to 20, done.
                                                ;we dont need to check 20,
                    mov rax, r9
                    mov rbx, rcx                ;we increment count in 20s
                    xor rdx, rdx                ;so we already know it will be
                    div rbx
                    cmp rdx, 0
                    jne .not_found
                    inc rcx
                    jmp .loop_start


    .not_found:
                    mov rax, 0
                    ret

    .found:         
                    mov rax, 1
                    ret
                    


