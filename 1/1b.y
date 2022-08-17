%{
	#include <stdio.h>
	#include <stdlib.h>
	int yyerror();	
%}
%start S
%%
S : A B
|
;
A : 'a' A 'b'
|
;
B : 'b' B 'c'
|
;
%%

int main(){
	printf("Enter Expression : ");
	yyparse();
	printf("Valid\n");
	return 0;
}

int yyerror(){
	printf("\nInvalid\n");
	exit(1);
}
