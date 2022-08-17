%{
	#include <stdio.h>
	#include <stdlib.h>
	int yyerror();
%}
%token id
%start S
%%
S: E {printf("\nResult : %d\n",$$);}
;
E: E '+' E {$$ = $1 + $3;}
 | E '-' E {$$ = $1 - $3;}
 | E '*' E {$$ = $1 * $3;}
 | E '/' E {$$ = $1 / $3;}
 | '(' E ')' {$$ = $2;}
 | id {$$ = $1;}
;
%%
int main(){
	printf("Enter Expresion : ");
	yyparse();
	return 0;
}

int yyerror(){
	printf("\nError !! Invalid expression\n");
	exit(1);
}
