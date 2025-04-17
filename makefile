SRC = $(shell echo ./kernel/*.asm ./benlib/*.asm)
SRC += boot/boot.asm fs/utils.asm
OBJ = ${SRC:.asm=.o}

all : benos.bin

benos.bin : ${OBJ} linker.ld
	ld -o $@ ${OBJ} -T linker.ld
%.o : %.asm
	nasm -f elf32 -o $@ $^ -i./include
clean:
	rm -f ${OBJ}
