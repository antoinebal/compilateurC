compiler:y.tab.c lex.yy.c
	gcc lex.yy.c y.tab.c -o compiler -ly -ll

lex.yy.c: compiloC.l
	flex compiloC.l

y.tab.c: compiler.y
	yacc -d -v -t compiler.y
test:compiler
	./compiler < test
