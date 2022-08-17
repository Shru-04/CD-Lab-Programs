%{
	#include <stdio.h>
	#include "y.tab.h"
	int yywrap(void);
%}
%%
"int"|"float"|"double"|"short"|"char"|"long" { return type;}
"void" { return VOID;}
"return" { return RET;}
[a-zA-Z_][a-zA-Z0-9_]* { return id;}
[0-9]+ {  yylval = atoi(yytext); return NUM;}
[ \t] {;}
\n {;}
. { return yytext[0];}
%%

int yywrap(void){
	return 1;
}