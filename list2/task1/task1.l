%{
#include <stdio.h>
int yywrap();
int yylex();
int lineNumber = 0;
int wordsCount = 0;
%}
%%
^[ \t]+ ;
[ \t]+$ ;
[ \t]+      printf(" ");
[^ \t\n]+     { printf("%s", yytext); wordsCount++; }
\n         { printf("\n"); lineNumber++; }
%%
int yywrap() {
    printf("---\nLines: \%d\nWords: \%d\n", lineNumber, wordsCount);
    return 1;
}
int main() {
    return yylex();
}