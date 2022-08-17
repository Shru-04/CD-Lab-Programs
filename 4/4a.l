%{
	#include <stdio.h>
	#include <fcntl.h>
	extern FILE *yyin;
	int yywrap(void);
	int ck=0, ci=0, cop = 0;
%}
%%
"for"|"float"|"int"|"double"|"char"|"void"|"main"|"include"|"return" ck++;
[a-zA-Z_][a-zA-Z0-9_]* ci++;
"<"|">"|"<="|">="|"!="|"==" cop++;
[+]|[=]|[-]|[/]|['*']|['!']|['^']|['%']|['&']|['~'] cop++;
. ;
\n ;
%%
int main(){
	yyin = fopen("4a_in.txt","r");
	yylex();
	printf("\nNo. of Identifiers = %d\nNo. of Keywords = %d\nNo. of Operators = %d\n",ci,ck,cop);
	return 0;
}

int yywrap(void){
	return 1;
}
