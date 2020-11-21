;Find the sum of all multiples of 3 or 5 below 1000
                    section .text
limit: dq 1000

                    section .bss

                    section .text

                    global _start
_start:
                    xor rcx, rcx                ;start loop at 0
                    xor r8, r8                  ;holds running total
    start_loop:
                    inc rcx                     ;loop counter
                    cmp rcx, qword [limit]      ;loop limit
                    je end_program              ;loop exit
                    mov rax, rcx                ;put ecx in rax to call
                    call modulo                 ;call our function
                    cmp rax, 0                  ;if false, carry on
                    je start_loop
                    add r8, rcx                 ;otherwise add to total
                    jmp start_loop
    end_program:
                    mov rax, 60                 ;exit
                    xor rdi, rdi
                    syscall


modulo:                                         ;returns 1 if multiple of 3|5
                    mov r9, rax                 ;backup rax
                    xor rdx, rdx                ;clear rdx
                    mov rbx, 3                  ;check 3
                    div rbx                     ;result in rax
                    cmp rdx, 0                  ;remainder in rdx
                    je .modulo_true

                    xor rdx, rdx
                    mov rbx, 5                  ;check 5
                    mov rax, r9                 ;restore overwritten rax
                    div rbx                     
                    cmp rdx, 0                  ;remainder in rdx
                    je .modulo_true             ;return true

                    mov rax, 0                  ;return false
                    ret

    .modulo_true:
                    mov rax, 1
                    ret

