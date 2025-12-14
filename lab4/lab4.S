   .section .note.GNU-stack,""
   .global lab4, is_prime, largest_power_unsigned, overflowing_subtract, dumb
   .text
#Question 1:
   
is_prime:
   push   %rbx
   mov    %rdi, %rbx
   mov    $2, %rcx
   
.loop:
   cmp    %rbx, %rcx
   jge    .prime
   
   mov    $0, %rdx
   mov    %rdi, %rax
   div    %rcx

   cmp    $0, %rdx
   je     .is_not_prime
   
   inc    %rcx
   jmp    .loop

.is_not_prime:
   pop    %rbx
   mov    $0, %rax
   ret
   
.prime:
   pop    %rbx
   mov    $1, %rax
   ret
   
#Question 2:

largest_power_unsigned:
   push   %rbx
   mov    %rdi, %rbx
   mov    $1, %rax
   mov    %rax, %rcx
   
   jmp    .loop_till_flag
   
.loop_till_flag:
   
   mul   %rbx
   jo   .overflow_value

   mov   %rax, %rcx
   jmp   .loop_till_flag

.overflow_value: 
   mov   %rcx, %rax
   pop   %rbx
   ret

#Question 3:

overflowing_subtract:
   mov   %rdi, %rax
   sub   %rsi, %rax
   jo    .overflowed
   
   ret
.overflowed:
   mov   $0, %rax
   ret

#Question 4:

dumb:
   push  %rbx  #a
   push  %r12  #b
   mov   %rdi, %rbx  
   mov   %rsi, %r12
   
   cmp   $0, %rbx
   je    .dumb_a
   
   cmp   $0, %r12
   je    .dumb_b
   
   jmp   .dumb_recursive

.dumb_a:
   add   $1, %r12
   mov   %r12, %rax
   pop   %rbx
   pop   %r12
   ret  
.dumb_b:
   mov   %rbx, %rax
   pop   %rbx
   pop   %r12
   ret
.dumb_recursive:
   mov   %rbx, %rdi
   sub   $1, %rdi
   
   mov   %r12, %rsi
   sub   $1, %rsi
   
   
   call  dumb
   
   add   %rbx, %rax
   add   %rbx, %rax
   add   %r12, %rax
   
   pop   %rbx
   pop   %r12
   ret
   
   
   ret
