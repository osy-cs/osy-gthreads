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

.intel_syntax noprefix

_gtswtch:
gt_swtch:

        mov     [ rdi + 0x10 ], r15
        mov     [ rdi + 0x18 ], r14
        mov     [ rdi + 0x20 ], r13
        mov     [ rdi + 0x28 ], r12
        mov     [ rdi + 0x30 ], rbx

        mov     r15, [ rsi + 0x10 ]
        mov     r14, [ rsi + 0x18 ]
        mov     r13, [ rsi + 0x20 ]
        mov     r12, [ rsi + 0x28 ]
        mov     rbx, [ rsi + 0x30 ]

_gt_pree_swtch:
gt_pree_swtch:
        mov     [ rdi + 0x00 ], rsp
        mov     [ rdi + 0x08 ], rbp

        mov     rsp, [ rsi + 0x00 ]
        mov     rbp, [ rsi + 0x08 ]

        ret
