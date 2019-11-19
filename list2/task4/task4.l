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
    if (top < 0) {
        err = 1;
        return 0;
    }
    return stack[top];
}

void push(int val) {
    if (top < STACK_SIZE) {
        stack[top] = val;
        top++;
    } else {
        err = 1;
    }
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
                        push(atoi(yytext));
                        if (err) BEGIN(ERROR);
                    };

"+"                 {
                        push(pop() + pop());
                        printf("%d", err);
                        if (err) BEGIN(ERROR);
                    };

"*"                 {
                        push(pop() * pop());
                        if (err) BEGIN(ERROR);
                    };

"/"                 {   
                        int a = pop();
                        if (a == 0) {
                            printf("Nie dzielimy przez zero.\n");
                            BEGIN(ERROR);
                        } else {
                            push(pop() / a);
                        }
                        if (err) BEGIN(ERROR);
                    };

-                   {
                        int a = pop();
                        push(pop() - a);
                        if (err) BEGIN(ERROR);
                    };

"^"                 {
                        int a = pop();
                        if (a < 0) {
                            printf("Zły argument: ujemne potęgowanie \n");
                            BEGIN(ERROR);
                        } else {
                            push(power(pop(), a));
                        }
                        if (err) BEGIN(ERROR); 
                    };

"%"                 {
                        int a = pop();
                        if (a == 0) {
                            printf("Nie dzielimy przez zero.\n");
                            BEGIN(ERROR);
                        } else {
                            push(pop() % a);
                        }
                        if (err) BEGIN(ERROR);
                    };                    

\n                  printf("= %d\n", pop());

[[:blank:]]         ;
[^[:blank:]]        {
                        printf("Zły symbol: %s\n", yytext);
                        BEGIN(ERROR);
                    };


<ERROR>.*           ;
<ERROR>\n           {
                        top = 0;
                        err = 0;
                        BEGIN(INITIAL);
                    };
%%
int yywrap() {
    return 1;
}
int main() {
    return yylex();
}