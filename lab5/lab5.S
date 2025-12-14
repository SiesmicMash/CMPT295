   .section .note.GNU-stack,""
   .global lab5, fibonacci, polynomial1, polynomial2, is_odd1, is_odd2, mul1, mul2
   .text
   
   
#Question 1:

fibonacci:
    push   %rbx
    push   %r12
    push   %r13
    mov    %rdi, %rbx
    
    cmp    $1, %rbx
    jle    .fib_over

.fib_recur:
    mov    %rbx, %rdi
    sub    $1, %rdi
    call   fibonacci
    mov    %rax, %r12
    
    mov    %rbx, %rdi
    sub    $2, %rdi
    call   fibonacci
    mov    %rax, %r13
    
    mov    %r12, %rax
    add    %r13, %rax
    jmp    .fib_done
    
.fib_over:
    mov    %rbx, %rax

.fib_done:
    pop    %r13
    pop    %r12
    pop    %rbx
    ret
    
#Question 2: Part1:

polynomial1:
    push   %rbx
    mov    %rdi, %rbx
    call   xcubed
    mov    %rax, %r9
    imul   %rsi, %r9
    
    call   xsquared
    mov    %rax, %r10
    imul   %rdx, %r10
    
    imul   %rbx, %rcx
    
    mov    %r9, %rax
    add    %r10, %rax
    add    %rcx, %rax
    add    %r8,  %rax
    
    pop    %rbx
    ret 

xcubed:
    mov    %rbx, %rax
    imul   %rbx, %rax
    imul   %rbx, %rax
    ret 
    
xsquared:
    mov    %rbx, %rax
    imul   %rbx, %rax
    ret

polynomial2:
    push   %rbx
    mov    %rdi, %rbx

    mov    %rsi, %r9
    imul   %rbx, %r9
    
    add    %rdx, %r9
    imul   %rbx, %r9
    
    add    %rcx, %r9
    imul   %rbx, %r9
    mov    %r8, %rax
    add    %r9, %rax 
    
    pop    %rbx
    ret

#Question2: part 2:
is_odd1:
    mov   %rdi, %rax
    mov   $2, %r8
        
    cqo 
    idiv  %r8
    cmp   $0, %rdx
    je    .is_even
    
    mov   $1, %rax
    ret
.is_even:
    mov   $0, %rax
    ret

is_odd2:
    mov   %rdi, %r8
    and   $1, %r8
    
    cmp   $0, %r8
    je    even
    
    mov   $1, %rax
    ret
even:
    mov   $0, %rax
    ret
    
#Question2: part 3:

mul1:
    mov   %rdi, %rax
    mov   $65537, %r8
    mul   %r8
    ret
    
mul2:
    mov   %rdi, %rax
    mov   %rax, %r8
    shl   $16, %rax
    add   %r8, %rax
    ret 
    
