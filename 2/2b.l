%{
	#include <stdio.h>
	#include "y.tab.h"
	//int yylval;
	int yywrap(void);
%}
%%
[0-9]+ { yylval = atoi(yytext); return id;}
[+] return '+';
[-] return '-';
[*] return '*';
[/] return '/';
[(] return '(';
[)] return ')';
\n return 0;
. return yytext[0];
%%

int yywrap(void){
	return 1;
}
