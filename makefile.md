# Makefile 语法
```Makefile
IN=main.c cradle.c
OUT=main
FLAGS=-Wall -Werror

all:
	gcc -o $(OUT) $(IN) $(FLAGS)

run:
	./$(OUT)
```
