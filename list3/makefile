
.PHONY = all clean cleanall

all: calc.tab.cpp lex.yy.c
	g++ -o calculator calc.tab.cpp lex.yy.c

calc.tab.cpp: calc.ypp
	bison -d calc.ypp
    
lex.yy.c: calc.l
	flex calc.l

clean:
	rm -f *.cpp *.hpp *.c

cleanall: clean
	rm -f calculator