   .section .note.GNU-stack,""
   .global lab6, strlen_mine, strlen_utf8
   .text
   
strlen_mine:
   mov     $0, %rcx
  
.calc_len:
   cmpb    $0, (%rdi)
   je      .finished
   inc     %rdi
   inc     %rcx
   jmp     .calc_len
   
.finished:
   mov     %rcx, %rax
   ret
   
strlen_utf8:
   mov     $0, %rcx
   
.loop:
   movzb   (%rdi), %r8
   cmp     $0, %r8
   je      .done
    
   and     $0b11000000, %r8
   cmp     $0b10000000, %r8
   je      .out
   inc     %rcx
   
.out:
   inc     %rdi
   jmp     .loop
.done:
   mov     %rcx, %rax
   ret
   
   
