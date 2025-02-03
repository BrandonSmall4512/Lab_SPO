%{
#include <stdio.h>
#include <ctype.h>


void process_sentence(char *sentence);
%}

%%

[ \t]+              ;  
([^.?!]+[.!?])      {  
                        
                        while (isspace(*yytext)) {
                            yytext++;
                        }
                        if (isupper((unsigned char)yytext[0])) {
                            process_sentence(yytext);
                        }
                    }

\n                  ;  

%%

void process_sentence(char *sentence) {
    printf("%s\n", sentence);  
}

int main(int argc, char **argv) {
    if (argc > 1) {
        FILE *file = fopen(argv[1], "r");
        if (!file) {
            perror("Error opening file");
            return 1;
        }
        yyin = file;
    }
    yylex();  
    return 0;
}
