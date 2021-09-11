var = C:\\Users\\postgresh\\Desktop\\Программирование\\Программы\\\Project_makefile\\


all: main

main: hash.o hello.o sum.o
	gcc hash_1.o hello.o sum.o -o res

hash.o:
	gcc -c hash_1.c

hello.o:
	gcc -c $(var)hello\\hello.c

sum.o:
	gcc -c $(var)sum\\sum.c


clean:
	del *.o res.exe
