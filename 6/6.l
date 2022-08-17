%{
	#include "y.tab.h"
	#include <stdio.h>
	int yywrap(void);
%}
%%
[0-9]+ { yylval.sym = (char)yytext[0]; return NUM;}
[a-zA-Z]+ { yylval.sym = (char)yytext[0]; return id;}
\n return 0;
. return yytext[0];
%%

int yywrap(void){
	return 1;
}
