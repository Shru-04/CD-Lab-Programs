%{
	#include "y.tab.h"
	int yywrap(void);
%}
%%
"if" {return IF;}
"else" {return ELSE;}
[(] {return '(';}
[)] {return ')';}
[{] {return '{';}
[}] {return '}';}
[a-zA-Z_][a-zA-Z0-9_]* {return id;}
[0-9]+ {yylval=atoi(yytext);return NUM;}
"<"|">"|"<="|">="|"=="|"!=" {return ROP;}
[=] {return '=';}
[+] {return '+';}
[-] {return '-';}
"*" {return '*';}
[/] {return '/';}
[;] {return ';';}
[ \t\n] {;}
. {;}
%%

int yywrap(void){
	return 1;
}

