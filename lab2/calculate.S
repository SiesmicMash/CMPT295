    .section .note.GNU-stack,""
    .global calculate
    .text

#Usaid Syed 301655464
f:
   mov %rax, %rdi
   imul %rax, %rdi
   add %rax, %rsi
   ret

calculate:
    # holds a
    push %rbx
    
    # x = %r9
    mov %rdi, %r9
    
    #a = x +3
    mov %rdi, %rax
    add $3, %rax
    mov %rax, %rbx
    
    #b = f(x, a)
    mov %r9, %rdi
    mov %rbx, %rsi
    call f
    mov %rax, %rcx
    
    #c = f(b,x)
    mov %rcx, %rdi
    mov %r9, %rsi
    call f
    mov %rax, %rdx
    
    #d = f(x,c)
    mov %r9, %rdi
    mov %rdx, %rsi
    call f
    mov %rax, %r8
    
    #return a + b + c + d
    mov %rbx, %rax
    add %rcx, %rax
    add %rdx, %rax
    add %r8, %rax
    
    pop %rbx
    ret
    
