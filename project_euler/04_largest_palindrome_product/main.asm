;Find the largest palindrome made from the product of two 3-digit numbers
                    section .data

                    section .bss

                    section .text
                    global _start
_start:

                    xor r10, r10                ;outer loop index
                    xor r11, r11                ;inner loop index
                    xor r8, r8                  ;largest palindrome
                    mov r14, 1000               ;loop limit

    .loop_outer:
                    inc r10
                    cmp r10, r14                ;check for loop limit
                    je .end_program             

        .loop_inner:                    
                    inc r11
                    cmp r11, r14                ;if limit reached then end
                    je .inner_end

                    mov r12, r10
                    imul r12, r11               ;inner index * outer index
                    mov rax, r12
                    call reverse_num            ;reverse and check if same
                    cmp rax, r12
                    jne .loop_inner             ;if not equal, continue

                    cmp rax, r8                 ;if equal, is it largest?
                    jle .loop_inner
                    mov r8, rax
                    jmp .loop_inner

        .inner_end:
                    xor r11, r11
                    jmp .loop_outer

    .end_program:
                    mov rax, 60                 ;exit
                    xor rdi, rdi
                    syscall




reverse_num:
                    xor r9, r9
                    xor rcx, rcx                ;keep count of stack pushes
    .push_digits:
                    mov rbx, 10                 ;we use modulo to get the
                    xor rdx, rdx                ;last digit of the number
                    div rbx                     ;then push it onto stack.
                    push rdx                    ;rcx keeps track of the
                    inc rcx                     ;signficance of each digit.
                    cmp rax, 0                  ;once there is no number left,
                    jne .push_digits            ;its all on the stack

                    xor rdx, rdx
                    xor rdi, rdi
    .pop_digits:
                    cmp rdi, rcx                ;we then pull each digit
                    je .reverse_done            ;off the stack and multiply
                    pop rdx                     ;by appropriate exponent.
                    mov rax, rdi                ;since we reverse significance,
                    call calc_power             ;we count up to rcx from 0
                    imul rdx, rax               ;counting down to 0 from rcx
                    inc rdi                     ;would give us the same
                    add r9, rdx                 ;as what we put in
                    jmp .pop_digits             ;running total is in r9
    .reverse_done:
                    mov rax, r9
                    ret
                    
calc_power:                                     ;returns 10^eax
                    cmp rax, 0                  ;anything^0 = 1
                    je .base_case               ;so thats our base case
                    mov rbx, 10
                    dec rax
                    call calc_power             ;else, recurse
                    imul rax, rbx
                    ret
    .base_case
                    mov rax, 1
                    ret
