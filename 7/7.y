%{
	#include <stdio.h>
	#include <fcntl.h>
	#include <stdlib.h>
	extern FILE *yyin;
	int flag=0, f2 = 0;
	int yyerror();
%}
%token type VOID id NUM RET
%start S
%%
S: type id '(' ARG ')' ST S{flag = 1;}
| VOID id '(' ARG ')' ST S {flag = 0;}
| VOID id '(' ')' ST S
| type id '(' ')' ST S {flag=1;}
| type id '(' ARG ')' ';' S {flag = 1;}
| VOID id '(' ARG ')' ';' S
|
;
ARG: type VAR
| type VAR ',' ARG
;
VAR: id
| id '[' ']'
| id '=' NUM
;
ST: '{' EQU ST RETURN '}'
| '{' EQU ST '}' { f2 = 1;} 
|
;
EQU: id '=' id '+' id ';' EQU
|
;
RETURN: RET id ';'
| RET NUM ';'
| RET id '[' NUM ']' ';'
| RET ';' { f2 = 1;}
;
%%
int main(){
	yyin = fopen("7.c","r");
	yyparse();
	if (f2 && flag){
		printf("\n\nReturn missing or return value is missing !!\n\n");
		exit(0);
	}
	printf("\n\nFunction Def. is Valid in 7.c \n\n");
	return 0;
}

int yyerror(){
	printf("\nInvalid\n\n");
	exit(0);
}
