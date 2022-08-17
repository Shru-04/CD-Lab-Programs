%{
	#include "y.tab.h"
	int yywrap(void);
%}
%%
[a-z_][a-z0-9_]* { yylval.sym = (char)yytext[0]; return id;}
[0-9]+ { yylval.sym = (char)(yytext[0]); return digit;}
[ \t\n] return 0;
. return yytext[0];
%%

int yywrap (void){
	return 1;
}
