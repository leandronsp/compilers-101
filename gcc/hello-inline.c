#include <stdio.h>

int main() {
    asm (
        ".data\n"
        "message:\n"
        "    .ascii \"Hello, World!\\n\"\n"
        ".text\n"

        "mov $1, %%rax\n"      // syscall number for sys_write
        "mov $1, %%rdi\n"      // file descriptor 1 is stdout
        "lea message, %%rsi\n" // pointer to the message
        "mov $14, %%rdx\n"     // message length (including newline)
        "syscall\n"            // make the system call

        "mov $60, %%rax\n"     // syscall number for sys_exit
        "xor %%rdi, %%rdi\n"   // exit code 0
        "syscall\n"            // make the system call
        :
        :
        : "rax", "rdi", "rsi", "rdx"
    );

    return 0;
}
