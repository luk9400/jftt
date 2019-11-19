%{
#include <stdio.h>
#include <stdlib.h>
#define STACK_SIZE 16
int yywrap();
int yylex();

int stack[STACK_SIZE];
int top = 0;
int err = 0;

int pop() {
    top--;
    return stack[top];
}

void push(int val) {
    stack[top] = val;
    top++;
}

int isEmpty() {
    return top == 0 ? 1 : 0;
}

int isFull() {
    if (top == STACK_SIZE - 1) {
        return 1;
    } else {
        return 0;
    }
}

int power(int a, int b) {
    int acc = 1;
    for (int i = 0; i < b; i++) {
        acc *= a;
    }
    return acc;
}

%}

%x ERROR

%%
-?[[:digit:]]+      {
                        if (!isFull()) {
                            push(atoi(yytext));
                        } else {
                            err = 1;
                            BEGIN(ERROR);
                        }
                    };

"+"                 push(pop() + pop());

"*"                 push(pop() * pop());

"/"                 {   
                        int a = pop();
                        push(pop() / a);
                    };

-                   {
                        int a = pop();
                        push(pop() - a);
                    };

"^"                 {
                        int a = pop();
                        if (a < 0) {
                            printf("Zły argument: ujemne potęgowanie \n");
                            BEGIN(ERROR);
                        } else {
                            push(power(pop(), a));
                        } 
                    };

\n                  printf("= %d\n", pop());

[[:blank:]]         ;

<ERROR>.*           ;
<ERROR>\n           {
                        top = 0;
                        BEGIN(INITIAL);
                    };
%%
int yywrap() {
    return 1;
}
int main() {
    return yylex();
}