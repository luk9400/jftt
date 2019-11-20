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

    int docs = 0;
%}

singleline      \/[\\\n]*\/
multiline       \/[\\\n]*\*
multilineEnd    \*[\\\n]*\/


%x singleLine
%x multiLine
%x string
%x include

%%
{singleline}                BEGIN(singleLine);
<singleLine>.               ;
<singleLine>\n              BEGIN(INITIAL);



{multiline}                 BEGIN(multiLine);
<multiLine>.|\n             ;
<multiLine>{multilineEnd}   BEGIN(INITIAL);

\"                          { ECHO; BEGIN(string); };
<string>\"                  { ECHO; BEGIN(INITIAL); };

#include[[:blank:]]*\<      { ECHO; BEGIN(include); };
<include>\>                 { ECHO; BEGIN(INITIAL); };
<include>.|\n               ECHO;
               
%%
int yywrap() {
    return 1;
}
int main() {
    return yylex();
}