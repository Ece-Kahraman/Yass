parser: y.tab.c lex.yy.c
	gcc -o parser y.tab.c
y.tab.c: CS315s22_team05.yacc.y lex.yy.c
	yacc CS315s22_team05.yacc.y
lex.yy.c: CS315s22_team05.lex.l
	lex CS315s22_team05.lex.l
clean:
	rm -f lex.yy.c y.tab.c parser