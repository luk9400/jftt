%{
#include <stdio.h>
int yywrap();
int yylex();
int lineNumber = 0;
int wordsCount = 0;
%}
%%
^[ \t]* ;
[ \t]*$ ;
[ \t]* printf(" ");
^\n$ ;
\n$ { printf("\n"); lineNumber++; }
[ \t][^ \t][ \t] { printf("%s", yytext); wordsCount++; }
%%
int yywrap() {
    printf("---\nLines: \%d\nWords: \%d\n", lineNumber, wordsCount);
    return 1;
}
int main() {
    return yylex();
}