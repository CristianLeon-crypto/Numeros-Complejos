%{
#include <stdio.h>
%}

DIGIT     [0-9]
INT       -?{DIGIT}+
SPACE     [ \t]*

%%

{INT}{SPACE}"+"{SPACE}{INT}{SPACE}"i" {
    /* Caso: a + b i  ->  a+bi */
    int a, b;
    char sign[2] = "+";
    sscanf(yytext, "%d + %d", &a, &b);
    if (b < 0)
        printf("%d%di ACEPTA\n", a, b);
    else
        printf("%d+%di ACEPTA\n", a, b);
}

{INT}{SPACE}"+"{SPACE}"i" {
    /* Caso: a + i  ->  a+i */
    int a;
    sscanf(yytext, "%d", &a);
    printf("%d+i ACEPTA\n", a);
}

{INT}{SPACE}"+"{SPACE}{INT} {
    /* Caso: a + b (sin i)  ->  NO ACEPTA */
    int a, b;
    sscanf(yytext, "%d + %d", &a, &b);
    printf("%d+%d NO ACEPTA\n", a, b);
}

{INT} {
    /* Numero solo, sin parte imaginaria -> NO ACEPTA */
    printf("%s NO ACEPTA\n", yytext);
}

[ \t\n]+   { /* ignorar espacios y saltos de linea */ }

.          { /* ignorar caracteres no reconocidos */ }

%%

int yywrap() { return 1; }

int main() {
    yylex();
    return 0;
}