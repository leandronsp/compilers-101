FROM ruby:3.2 

RUN apt-get update && \
    apt-get install -y nasm gcc-multilib clang llvm
