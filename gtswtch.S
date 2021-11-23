#
#   Context switch.
#
#   %rdi contains the current context structure.
#   %rsi contains the context to switch to.
#
#   rbp is the base pointer, which points to the base of the current stack frame
#   rsp is the stack pointer, which points to the top of the current stack frame
#   The called routine is expected to preserve rsp, rbp, rbx, r12, r13, r14, and r15 but may trample any other registers.
#
#   see https://software.intel.com/en-us/articles/introduction-to-x64-assembly


.globl _gt_swtch, gt_swtch
.globl _gt_pree_swtch, gt_pree_swtch

_gtswtch:
gt_swtch:

        mov     %r15, 0x10(%rdi)
        mov     %r14, 0x18(%rdi)
        mov     %r13, 0x20(%rdi)
        mov     %r12, 0x28(%rdi)
        mov     %rbx, 0x30(%rdi)

        mov     0x10(%rsi), %r15
        mov     0x18(%rsi), %r14
        mov     0x20(%rsi), %r13
        mov     0x28(%rsi), %r12
        mov     0x30(%rsi), %rbx

_gt_pree_swtch:
gt_pree_swtch:
        mov     %rsp, 0x00(%rdi)
        mov     %rbp, 0x08(%rdi)

        mov     0x00(%rsi), %rsp
        mov     0x08(%rsi), %rbp
        
        ret 
