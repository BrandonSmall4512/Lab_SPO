%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

extern int yylex(void);
void yyerror(const char *s);
%}

%union {
    double dval;
}

%token <dval> NUMBER
%type <dval> expression

%left '+' '-'
%left '*' '/'
%right '^'

%%

input:
    | input expression '\n' { 
        if (floor($2) == $2) { 
            printf("Result: %.0lf\n", $2);
        } else {
            printf("Result: %lf\n", $2); 
        }
    }
    ;

expression:
    NUMBER { $$ = $1; }
    | expression '+' expression { $$ = $1 + $3; }
    | expression '-' expression { $$ = $1 - $3; }
    | expression '*' expression { $$ = $1 * $3; }
    | expression '/' expression { 
        if ($3 == 0) {
            yyerror("Division by zero");
            $$ = 0;
        } else {
            $$ = $1 / $3; 
        }
    }
    | expression '^' expression { $$ = pow($1, $3); }
    | '(' expression ')' { $$ = $2; }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main(void) {
    printf("Enter expressions:\n");
    yyparse();
    return 0;
}
