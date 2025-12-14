   .section .note.GNU-stack,""
   .global lab8, hailstone_length, hailstone_length_cmov
   .text

hailstone_length:
    push    %rbx
    mov     %rdi, %rbx
    mov     $0, %rcx
    
.loop:
    cmp     $1, %rbx
    je      .exit
    
    inc     %rcx
    mov     %rbx, %rax
    and     $1, %rax
    jz      .is_even
    
    imul    $3, %rbx
    add     $1, %rbx
    jmp     .loop

.is_even:
    shr     $1, %rbx
    jmp     .loop
    
.exit:
    mov     %rcx, %rax
    pop     %rbx
    ret 

hailstone_length_cmov:
    push    %rbx
    mov     %rdi, %rbx
    mov     $0, %rcx

.loop_2:
    cmp     $1, %rbx
    je      .exit_2
    
    inc     %rcx
    mov     %rbx, %rdx
    shr     %rdx

    lea     1(%rbx, %rbx, 2), %rax
    #(rbx + 2*rbx) + 1
    # %n + %y

    test    $1, %rbx
    cmovz   %rdx, %rbx
    cmovnz  %rax, %rbx 
    
    jmp     .loop_2

.exit_2:
    mov     %rcx, %rax
    pop     %rbx
    ret 
