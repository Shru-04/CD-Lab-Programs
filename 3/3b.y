%{
	#include <stdio.h>
	#include <stdlib.h>
	extern FILE *yyin;
	int yyerror();
	int cn=0;
%}
%token id NUM FOR type
%start S
%%
S: FOR '(' INIT ';' COND ';' UPT ')' '{' ST '}' {cn++;}
|
;
INIT: type id '=' NUM
| id '=' NUM
|
;
COND: id '<' NUM
| id '>' NUM
| id '=' '=' NUM
| id '<' '=' NUM
| id '>' '=' NUM
|
;
UPT: id '+' '+'
| id '-' '-'
| id '+' '=' NUM
| id '-' '=' NUM
|
;
ST: EQU ST
| S
|
;
EQU: id '=' id '+' id ';'
| id '=' id '-' id ';'
|
;
%%
int main(){
	yyin = fopen("3b.c","r");
	yyparse();
	printf("\nNo. of nested loops = %d",cn);
	return 0;
}

int yyerror(){
	printf("\nError !!\n");
	exit(0);
}
