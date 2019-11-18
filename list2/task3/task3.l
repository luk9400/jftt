%{
#include <stdio.h>
int yywrap();
int yylex();

    char* concat(const char* str1, const char* str2) {
        char* result = malloc(strlen(str1) + strlen(str2) + 1);
        strcpy(result, str1);
        strcat(result, str2);
        return result;
    }

    int err = 0;
    char* str = "";
%}

%x singleLine
%x multiLine
%x string

%%
\/\/                BEGIN(singleLine);
<singleLine>.       ;
<singleLine>\n      BEGIN(INITIAL);



\/\*                BEGIN(multiLine);
<multiLine>.|\n     ;
<multiLine>\*\/     BEGIN(INITIAL);

\"                  { ECHO; BEGIN(string); };
<string>\"        { ECHO; BEGIN(INITIAL); };
%%
int yywrap() {
    return 1;
}
int main() {
    return yylex();
}