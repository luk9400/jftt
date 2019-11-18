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

%x cdata
%x comment
%x variable

%%
\<!--               BEGIN(comment);
<comment>.|\n       str = concat(str, yytext);
<comment>\<!--|--   { err = 1; str = concat(str, yytext); };
<comment>--\>       { if (err) { printf("<!--%s-->", str); } str = ""; err = 0; BEGIN(INITIAL); };

\"                  { ECHO; BEGIN(variable); };
<variable>\"        { ECHO; BEGIN(INITIAL); };

\<!\[CDATA\[        { ECHO; BEGIN(cdata); };
<cdata>\]\]\>       { ECHO; BEGIN(INITIAL); };
%%
int yywrap() {
    return 1;
}
int main() {
    return yylex();
}