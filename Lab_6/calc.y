%{
#define YYSTYPE double
#include <math.h>
#include <stdio.h>
#include <ctype.h>
int yyerror(char *s);
int yylex();
%}
%token DATA

%%
spisok : 
       | spisok '\n'
       | spisok wyrag '\n' { printf("\t%g\n", $2); }
       ;

wyrag:
       summa
       ;

summa:
       product
       | summa '+' product { $$ = $1 + $3; }
       | summa '-' product { $$ = $1 - $3; }
       ;

product:
       power
       | product '*' power { $$ = $1 * $3; }
       | product '/' power { $$ = $1 / $3; }
       ;

power:
       unary
       | unary '^' power { $$ = pow($1, $3); } 
       ;

unary:
       factor
       | '-' factor { $$ = -$2; } 
       ;

factor:
       DATA { $$ = $1; }
       | '(' wyrag ')' { $$ = $2; } 
       ;

%%
int yyerror(char *s)
{
    fprintf(stderr, "%s\n", s);
    return 0;
}


int yylex()
{
    int c;
    do {
        c = getchar();
    } while (c == ' ' || c == '\t');

    if (c == EOF)
        return 0;
    
    if (c == '.' || isdigit(c)) {
        ungetc(c, stdin);
        scanf("%lf", &yylval);
        return DATA;
    }

    return c;
}

int main()
{
    printf("Введите выражение:\n");
    yyparse();
    return 0;
}
