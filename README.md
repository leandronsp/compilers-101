## Compilers 101

For a x86_64 architecture.

x86_64
```bash
$ cd gnu-as
$ as -o hello.o hello.s 
$ ld -o hello hello.o
$ ./hello
```

NASM x86_64
```bash
$ cd nasm
$ nasm -f elf64 hello.asm
$ ld -o hello hello.o 
$ ./hello
```

GCC
```bash
$ cd gcc
$ gcc -o hello hello.c 
$ ./hello

# using inline x86
$ gcc -no-pie -o hello-inline hello-inline.c
$ ./hello-inline
```

LLVM - CLANG
```bash
$ cd clang
$ clang -o hello hello.c 
$ ./hello

# or using LLC (AOT)
$ clang -S -emit-llvm hello.c -o hello.ll
$ llc hello.ll -o hello.s
$ clang hello.s -o hello
$ ./hello

# or using LLI (JIT)
$ clang -S -emit-llvm hello.c -o hello.ll
$ lli hello.ll
$ ./hello
```

Ruby generating LLVM IR
```bash
$ cd ruby 
$ ruby hello.rb
$ clang hello.ll -o hello
$ ./hello

# or using LLC
$ llc hello.ll -o hello.s
$ clang -no-pie hello.s -o hello
$ ./hello
``` 
