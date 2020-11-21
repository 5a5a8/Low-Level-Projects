#!/bin/bash
yasm -g dwarf2 -f elf64 main.asm -l main.lst -o main.o
ld -g main.o -o main.bin
#./main.bin
gdb < gdb.txt main.bin &> /dev/null
cat out.txt

#tidy up. modify this to keep the files
rm out.txt main.lst main.o
rm main.bin
