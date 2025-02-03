calc: calc.tab.c lex.yy.c
	gcc -o calc calc.tab.c lex.yy.c -lm

calc.tab.c calc.tab.h: calc.y
	bison -d calc.y

lex.yy.c: calc.l calc.tab.h
	flex calc.l

clean:
	rm -f calc lex.yy.c calc.tab.c calc.tab.h
