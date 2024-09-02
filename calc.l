%{
#include "calc.tab.h"
%}

%%

[0-9]+  { yylval = atoi(yytext); return NUMBER; }
[\t\n ] ; /* ignorar espaços e tabs */
.       { return yytext[0]; }

%%

int yywrap() {
    return 1;
}
