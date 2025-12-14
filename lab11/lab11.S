   .section .note.GNU-stack,""
   .global lab11, dot_double, dot_single, map_poly_double, map_poly_single, dot_double_vec, dot_single_vec, map_poly_double_vec, map_poly_single_vec
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

dot_double_vec:
    cmp     $0, %rdx
    je      .finished_dot_double

    shr     $2, %rdx
    vxorpd  %ymm0, %ymm0, %ymm0
.loop_dot__double_vec:
    vmovupd (%rdi), %ymm1
    vmovupd (%rsi), %ymm2

    vmulpd  %ymm1, %ymm2, %ymm2
    vaddpd  %ymm2, %ymm0, %ymm0

    add     $32, %rdi
    add     $32, %rsi
    dec     %rdx
    jne     .loop_dot__double_vec

    vextractf128 $0x1, %ymm0, %xmm1
    vaddpd %xmm1, %xmm0, %xmm0
    vshufpd $0b01, %xmm0, %xmm0, %xmm1
    vaddsd %xmm1, %xmm0, %xmm0

.finished_dot_double:
    vzeroupper
    ret

dot_single_vec:
    cmp     $0, %rdx
    je      .finished_dot_single

    shr     $3, %rdx
    vxorps  %ymm0, %ymm0, %ymm0

.loop_dot_single_vec:
    vmovups (%rdi), %ymm1
    vmovups (%rsi), %ymm2

    vmulps  %ymm1, %ymm2, %ymm2
    vaddps  %ymm2, %ymm0, %ymm0

    add     $32, %rdi
    add     $32, %rsi
    dec     %rdx
    jne     .loop_dot_single_vec

    vextractf128 $0x1, %ymm0, %xmm1
    vaddps %xmm1, %xmm0, %xmm0
    vshufps $0b00001110, %xmm0, %xmm0, %xmm1
    vaddps %xmm1, %xmm0, %xmm0
    vshufps $0b00000001, %xmm0, %xmm0, %xmm1
    vaddss %xmm1, %xmm0, %xmm0

.finished_dot_single:
    vzeroupper
    ret

map_poly_double_vec:
    cmp     $0, %rdx
    je      .finished_map_poly_double_vec

    shr     $2, %rdx

    vbroadcastsd    %xmm0, %ymm4
    vbroadcastsd    %xmm1, %ymm5
    vbroadcastsd    %xmm2, %ymm6
    vbroadcastsd    %xmm3, %ymm7

.loop_map_poly_double_vec:
    vmovupd (%rdi), %ymm0

    vmulpd  %ymm4, %ymm0, %ymm1

    vaddpd  %ymm5, %ymm1, %ymm1
    vmulpd  %ymm0, %ymm1, %ymm1

    vaddpd  %ymm6, %ymm1, %ymm1
    vmulpd  %ymm0, %ymm1, %ymm1

    vaddpd  %ymm7, %ymm1, %ymm1 

    vmovupd %ymm1, (%rsi)

    add     $32, %rdi
    add     $32, %rsi
    dec     %rdx
    jne     .loop_map_poly_double_vec

.finished_map_poly_double_vec:
    vzeroupper
    ret

map_poly_single_vec:
    cmp     $0, %rdx
    je      .finished_map_poly_single_vec

    shr     $3, %rdx

    vbroadcastss    %xmm0, %ymm4
    vbroadcastss    %xmm1, %ymm5
    vbroadcastss    %xmm2, %ymm6
    vbroadcastss    %xmm3, %ymm7

.loop_map_poly_single_vec:
    vmovups (%rdi), %ymm0

    vmulps  %ymm4, %ymm0, %ymm1

    vaddps  %ymm5, %ymm1, %ymm1
    vmulps  %ymm0, %ymm1, %ymm1

    vaddps  %ymm6, %ymm1, %ymm1
    vmulps  %ymm0, %ymm1, %ymm1

    vaddps  %ymm7, %ymm1, %ymm1 

    vmovups %ymm1, (%rsi)

    add     $32, %rdi
    add     $32, %rsi
    dec     %rdx
    jne     .loop_map_poly_single_vec

.finished_map_poly_single_vec:
    vzeroupper
    ret
