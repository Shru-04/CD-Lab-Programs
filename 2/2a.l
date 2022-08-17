%{
	#include <stdio.h>
	#include <stdlib.h>
	int cpi = 0, cni = 0, cpf = 0, cnf = 0;
%}
%%
[+]?[0-9]*[.]?[0-9]+[/][+]?[0-9]*[.]?[0-9]+ cpf++;
[-][0-9]*[.]?[0-9]+[/][-][0-9]*[.]?[0-9]+ cpf++;
[+]?[0-9]*[.][0-9]+ cpf++;
[+|-]?[0-9]*[.]?[0-9]+[/][+|-]?[0-9]*[.]?[0-9]+ cnf++;
[-][0-9]*[.][0-9]+ cnf++;
[+]?[0-9]+ cpi++;
[-]?[0-9]+ cni++;
. ;
\n return 1;
%%

int main(){
	printf("Enter Numbers :\n");
	yylex();
	printf("\nNumber of :------\nPositive Integers : %d\nNegative Integers : %d\nPositive Fractions : %d\nNegative Fractions : %d\n",cpi,cni,cpf,cnf);
	return 0;
}

int yywrap(void){
	return 1;
}
