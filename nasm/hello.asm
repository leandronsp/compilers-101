section .data
    hello db 'Hello, World!', 0xA

section .text
    global _start

_start:
    ; write our string to stdout
    mov rax, 1       ; syscall number for sys_write
    mov rdi, 1       ; file descriptor 1 is stdout
    mov rsi, hello   ; pointer to the hello string
    mov rdx, 14      ; length of the hello string
    syscall          ; invoke the kernel

    ; exit
    mov rax, 60      ; syscall number for sys_exit
    xor rdi, rdi     ; exit code 0
    syscall          ; invoke the kernel
