%{
	#include <stdio.h>
	#include <stdlib.h>
	int c=0;
	int yyerror();
	extern FILE *yyin;
%}
%token id NUM IF ELSE ROP
%start S
%%
S: IF '(' COND ')' ST {c++;}
| IF '(' COND ')' ST ELSE ST {c++;}
|
;
COND: id ROP id
| id ROP NUM
| NUM
|
;
ST: '{' EQU S '}'
|
;
EQU: id '=' id '+' id ';' EQU
| id '=' id '-' id ';' EQU
| id '=' id '*' id ';' EQU
| id '=' id '/' id ';' EQU
| id '+' '+' ';' EQU
| id '-' '-' ';' EQU
| id '-' '=' NUM ';' EQU
| id '+' '=' NUM ';' EQU
|
;
%%

int main(){
	yyin = fopen("4b_in.txt","r");
	yyparse();
	printf("\nNo. of nested IFs : %d",c);
	return 0;
}

int yyerror(){
	printf("\nError !! Invalid statement detected\n");
	exit(1);
}

