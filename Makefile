# http://pirate.shu.edu/~minimair/assembler/Makefile
#
all: main

asm_io.o : asm_io.asm
	nasm -dELF_TYPE -f elf -g asm_io.asm -o asm_io.o

asm_main.o : asm_main.asm
	nasm -l asm_main.list -f elf -g -F stabs asm_main.asm -o asm_main.o

intsqrt.o : intsqrt.asm
	nasm -dELF_TYPE -f elf -g intsqrt.asm -o intsqrt.o

sieve.o : sieve.asm
	nasm -dELF_TYPE -f elf -g sieve.asm -o sieve.o

main : asm_io.o asm_main.o intsqrt.o sieve.o
	gcc -m32 -o main asm_main.o asm_io.o intsqrt.o sieve.o main.c

run : 
	./main

edit:
	vim asm_main.asm

debug:
	gdb ./main

clean :
	@rm *.o *.list main
