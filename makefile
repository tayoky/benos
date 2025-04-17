SRC = $(shell echo ./kernel/*.asm ./benlib/*.asm)
SRC += fs/utils.asm
OBJ = ${SRC:.asm=.o}

all : benos.img

benos.img : kernel.bin boot.bin
	cp boot.bin benos.img
	cat kernel.bin >> benos.img

boot.bin : boot/boot.o boot.ld
	ld -o $@ boot/boot.o -T boot.ld

kernel.bin : ${OBJ} kernel.ld start.o
	ld -o $@ ${OBJ} -T kernel.ld
%.o : %.asm
	nasm -f elf64 -o $@ $^ -i./include
clean:
	rm -f ${OBJ}
