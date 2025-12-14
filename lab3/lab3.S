   .section .note.GNU-stack,""
   .global lab3, abs_value, power2, hailstone_length
   .text

abs_value:
    push    %rbx
    mov     %rdi, %rbx       
    test    %rbx, %rbx
    jge     .abs_val_final
    neg     %rbx

.abs_val_final:
    mov     %rbx, %rax
    pop     %rbx
    ret
    
power2:
    push    %rbx
    push    %r12
    push    %r13
    
    mov     %rdi, %rbx
    mov     $1, %r12
    mov     $0, %r13 
     
.powering_2:
    mov     %r12, %rdi
    call    print_uint64
    
    add     $1, %r13
    cmp     %rbx, %r13
    jg	    .finished
    
    add     %r12, %r12
    jmp     .powering_2

.finished:    
    pop     %rbx
    pop     %r12
    pop     %r13
    ret
    
hailstone_length:
    push    %rbx
    mov     %rdi, %rbx
    mov     $0, %rcx
.hailstone_loop:
    cmp     $1, %rdi
    je      .exit 
    
    add     $1, %rcx
    mov     %rdi, %r9
    and     $1, %r9 
    jz      .divide_by_2
    
    imul    $3, %rdi
    add     $1, %rdi
    jmp     .hailstone_loop
    
.divide_by_2:
    shr     $1, %rdi
    jmp     .hailstone_loop
    
.exit:
    mov     %rcx, %rax
    pop     %rbx
    ret
   
