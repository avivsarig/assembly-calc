ASM_FILES := $(shell find . -type f -name '*.asm')
OBJ_FILES := $(patsubst %.asm,%.o,$(ASM_FILES))

all: main clean

main: $(OBJ_FILES)
	ld $^ -o $@

%.o: %.asm
	nasm -f elf64 $< -o $@

clean:
	rm -f $(OBJ_FILES)
