   .section .note.GNU-stack,""
   .global lab7, randint, fill_array, dot, dot_struct

    .data
    seed:
        .quad 1

   .text


randint:
    mov     seed(%rip), %rax
    movabs  $6364136223846793005, %r8
    
    mul     %r8
    add     $1, %rax

    mov     %rax, seed(%rip)

    shr     $33, %rax
    ret

fill_array:
    push    %rbx
    push    %r12
    xor     %r12, %r12
    mov     %rsi, %rbx

    cmp     $0, %rbx
    je      .end


.loop:
    call    randint
    and     $0xff, %rax
    sub     $128, %rax

    mov     %rax, (%rdi)
    add     $8, %rdi

    inc     %r12
    cmp     %rbx, %r12

    jne     .loop

.end:
    pop     %r12
    pop     %rbx
    ret

dot:
    push    %rbx
    xor     %rax, %rax
    cmp     $0, %rdx
    je      .done

.loop_dot:
    mov     (%rdi), %rbx
    mov     (%rsi), %r8
    imul    %rbx, %r8

    add     %r8, %rax


    add     $8, %rdi
    add     $8, %rsi

    dec     %rdx
    jne     .loop_dot

.done:
    pop     %rbx
    ret

dot_struct:
    push    %rbx
    xor     %rax, %rax
    
    cmp     $0, %rsi
    je      .finished

.loop_struct:
    mov     (%rdi), %rbx
    mov     8(%rdi), %r8
    imul    %rbx, %r8
    add     %r8, %rax

    add     $16, %rdi

    dec     %rsi

    jne     .loop_struct

.finished:
    pop     %rbx
    ret




