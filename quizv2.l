%{
#include <stdio.h>
#include <string.h>

void print_without_newline(const char *s) {
    int n = strlen(s);
    if (s[n-1] == '\n') {
        fwrite(s, 1, n-1, stdout);
    } else {
        fputs(s, stdout);
    }
}
%}

WS      [ \t]*
SIGN    [+-]?
DIG     [0-9]
INT     {DIG}+
NUM     ({INT}(\.{INT})?|\.{INT})([eE][+-]?{INT})?
REAL    {SIGN}{NUM}
IMAG    {SIGN}{NUM}?[i]
COMPLEX {SIGN}{NUM}{WS}[+-]{WS}{NUM}?[i]

%%

{WS}{COMPLEX}{WS} {
    /* Caso: numero complejo completo -> ACEPTA */
    print_without_newline(yytext);
    printf(" ACEPTA\n");
}

{WS}{IMAG}{WS} {
    /* Caso: solo parte imaginaria -> ACEPTA */
    print_without_newline(yytext);
    printf(" ACEPTA\n");
}

{WS}{REAL}{WS} {
    /* Caso: solo parte real, sin i -> NO ACEPTA */
    print_without_newline(yytext);
    printf(" NO ACEPTA\n");
}

[ \t\n]+   { /* ignorar espacios y saltos de linea */ }

.          { /* ignorar caracteres no reconocidos */ }

%%

int yywrap() { return 1; }

int main() {
    yylex();
    return 0;
}