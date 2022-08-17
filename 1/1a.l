%{
	#include <stdio.h>
	#include <fcntl.h>
	#include <stdlib.h>
	extern FILE *yyin;
	int cw = 0, cl = 0, cc = 0, cs=0;
%}
%%
[a-zA-Z0-9]+ {cw++; cc += yyleng; }
[\n] {cl++; cc += 1;}
[ ] {cs++; cc++;}
[\t] {cs+=4; cc+=4;}
. cc++;
%%

int main(){
	yyin = fopen("a1.txt","r+");
	yylex();
	printf("\n\nNo. of Words = %d\nNo. of Lines = %d\nNo. of Characters = %d\nNo. of Whitespaces = %d\n",cw,cl,cc,cs);
	return 0;
}
int yywrap(void){
	return 1;
}
