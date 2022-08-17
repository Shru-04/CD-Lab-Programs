%{
	#include <stdio.h>
	#include <stdlib.h>
	int cl = 0, flag = 0;
	extern FILE *yyin, *yyout;
	int yywrap();
%}
%%
[/][/](.)* { cl++;}
"/*" flag = 1;
"*/" { if (flag == 1){ cl++; flag = 0;}}
. { if (flag == 0) {fprintf(yyout,"%s",yytext);}}
\n { fprintf(yyout,"%s",yytext); if (flag == 1){ cl++;}}
%%
int main(){
	yyin = fopen("3a_in.txt","r");
	yyout = fopen("3a_out.txt","w+");
	yylex();
	printf("\nNo. of Comment Lines : %d\n",cl);
	return 0;
}

int yywrap(void){
	return 1;
}
