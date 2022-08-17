%{
	#include "y.tab.h"
	int yywrap(void);
%}
%%
"for" {return FOR;}
"int" | "char" | "float"|"double" {return type;}
[0-9]+ {yylval = atoi(yytext); return NUM;}
[a-zA-Z_][A-Za-z0-9_]* {return id;}
[ \t\n] {;}
. {return yytext[0];}
%%

int yywrap(void){
	return 1;
}
