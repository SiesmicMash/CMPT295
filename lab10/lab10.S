   .section .note.GNU-stack,""
   .global lab10, dot_double, dot_single, map_poly_double, map_poly_single, sin_x87
   .text


dot_double:
    xorpd   %xmm0, %xmm0
    cmp    $0, %rdx
    je      .done

.loop_dot:
    movsd   (%rdi), %xmm1
    movsd   (%rsi), %xmm8
    mulsd   %xmm1, %xmm8

    addsd   %xmm8, %xmm0

    add     $8, %rdi
    add     $8, %rsi

    dec     %rdx
    jne     .loop_dot

.done:
    ret

dot_single:
    xorps   %xmm0, %xmm0
    cmp     $0, %rdx
    je      .done_single

.loop_dot_single:
    movss   (%rdi), %xmm1
    movss   (%rsi), %xmm8
    
    mulss   %xmm1, %xmm8
    addss   %xmm8, %xmm0
    
    add     $4, %rdi
    add     $4, %rsi

    dec     %rdx
    jne     .loop_dot_single

.done_single:
    ret

map_poly_double:
    cmp     $0, %rdx
    je      .done_poly

.loop_poly:
    movsd   (%rdi), %xmm8
    
    movsd   %xmm0, %xmm9
    mulsd   %xmm8, %xmm9

    addsd   %xmm1, %xmm9
    mulsd   %xmm8, %xmm9

    addsd   %xmm2, %xmm9
    mulsd   %xmm8, %xmm9

    addsd   %xmm3, %xmm9

    movsd   %xmm9, (%rsi)

    add     $8, %rdi
    add     $8, %rsi

    dec     %rdx
    jne     .loop_poly

.done_poly:
    ret

map_poly_single:
    cmp     $0, %rdx
    je      .done_poly_single

.loop_poly_single:
    movss   (%rdi), %xmm8
    
    movss   %xmm0, %xmm9
    mulss   %xmm8, %xmm9

    addss   %xmm1, %xmm9
    mulss   %xmm8, %xmm9

    addss   %xmm2, %xmm9
    mulss   %xmm8, %xmm9

    addss   %xmm3, %xmm9

    movss   %xmm9, (%rsi)

    add     $4, %rdi
    add     $4, %rsi

    dec     %rdx
    jne     .loop_poly_single

.done_poly_single:
    ret

sin_x87:
    mov $0, %rcx
s87_loop:
    cmp %rdx, %rcx
    jae s87_ret
    fldl (%rdi, %rcx, 8)
    fsin
    fstpl (%rsi, %rcx, 8)
    inc %rcx
    jmp s87_loop
s87_ret:
    ret
