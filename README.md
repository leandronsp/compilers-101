## Compilers 101

NASM x86
```bash
$ cd nasm
$ nasm -f elf hello.asm
$ ld -m elf_i386 -o hello hello.o 
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

CLANG
```bash
$ cd clang
$ clang -o hello hello.c 
$ ./hello

# or using LLC
$ clang -S -emit-llvm hello.c -o hello.ll
$ llc hello.ll -o hello.s
$ clang hello.s -o hello
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
