.section .data
hello:
    .ascii "Hello, World!\n"

.section .text
.global _start

_start:
    # write our string to stdout
    movq $1, %rax         # syscall number for sys_write
    movq $1, %rdi         # file descriptor 1 is stdout
    movq $hello, %rsi     # pointer to the hello string
    movq $14, %rdx        # length of the hello string plus newline character
    syscall               # invoke the kernel

    # exit
    movq $60, %rax        # syscall number for sys_exit
    xorq %rdi, %rdi       # exit code 0
    syscall               # invoke the kernel
