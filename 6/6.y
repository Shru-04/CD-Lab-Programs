%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#include <ctype.h>
	void ThreeAddrCode();
	char AddToTable(char,char,char);
	void Quadruple();
	int yyerror();
	char temp='A';
	int ind=0;
	struct codegen{
		char op1;
		char opr;
		char op2;
	};
%}
%token<sym> NUM id
%union{
	char sym;
}
%type <sym> expr S
%start S
%%
S: id '=' expr {$$ = AddToTable((char)$1,(char)$3,'=');}
| expr
;
expr: expr '+' expr {$$ = AddToTable((char)$1,(char)$3,'+');}
| expr '-' expr {$$ = AddToTable((char)$1,(char)$3,'-');}
| expr '*' expr {$$ = AddToTable((char)$1,(char)$3,'*');}
| expr '/' expr {$$ = AddToTable((char)$1,(char)$3,'/');}
| '(' expr ')' {$$ = (char)$2;}
| id {$$ = (char)$1;}
| NUM {$$ = (char)$1;}
;
%%
struct codegen code[100];
//ind = 0;

char AddToTable(char op1, char op2, char opr){
	code[ind].op1 = op1;
	code[ind].op2 = op2;
	code[ind].opr = opr;
	ind++;
	temp++;
	return temp;
}

void ThreeAddrCode(){
	int i = 0;
	printf("\n\n\t\t--Three Address Code--\n");
	temp++;
	while (i < ind){
		printf("%c\t:=\t",temp);
		if (isalpha(code[i].op1))
			printf("%c\t",code[i].op1);
		else
			printf("%c\t",temp);
		printf("%c\t",code[i].opr);
		if (isalpha(code[i].op2))
			printf("%c\n",code[i].op2);
		else
			printf("%c\n",temp);
		temp++;
		i++;
	}
}

void Quadruple(){
	int i = 0;
	printf("\n\n\t\t--Quadruple--\n");
	temp++;
	while (i < ind){
		printf("%d\t|\t",i);
		printf("%c\t",code[i].opr);
		if (isalpha(code[i].op1))
			printf("%c\t",code[i].op1);
		else
			printf("%c\t",temp);
		if (isalpha(code[i].op2))
			printf("%c\t",code[i].op2);
		else
			printf("%c\t",temp);
		printf("%c\n",temp);
		temp++;
		i++;
	}
}


int main(){
	printf("\n\t\t--3 Address CodeGen---\nEnter the expression : ");
	yyparse();
	temp = 'A';
	ThreeAddrCode();
	temp = 'A';
	Quadruple();
	return 0;
}

int yyerror(){
	printf("\nInvalid\n");
	exit(0);
}
