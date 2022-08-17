%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#include <ctype.h>
	int ind=0, it=0, regnum=0,t1,t2;
	char temp = 'A';
	struct codegen{
		char op1;
		char op2;
		char opr;
		char regstr;
	};
	char AddToCode(char, char, char);
	void produceAssem();
	int yyerror();
%}
%union{
	char sym;
}
%type <sym> S expr
%token <sym> id digit
%left '+' '-'
%left '*'
%right '='
%start S
%%
S: id '=' expr { $$ = AddToCode((char)$1,(char)$3,'=');}
| expr
;
expr: expr '+' expr {$$ = AddToCode((char)$1,(char)$3,'+');}
| expr '-' expr {$$ = AddToCode((char)$1,(char)$3,'-');}
| expr '*' expr {$$ = AddToCode((char)$1,(char)$3,'*');}
| '(' expr ')' {$$ = (char)$2;}
| id {$$ = (char)$1;}
| digit {$$ = (char)$1;}
;
%%
struct codegen assem_code[100];

char AddToCode(char op1, char op2, char opr){
	assem_code[ind].op1 = op1;
	assem_code[ind].op2 = op2;
	assem_code[ind].opr = opr;
	assem_code[ind].regstr = (temp+1);
	ind++;
	temp++;
	return temp;
}

void produceAssem(){
	temp++;
	//regnum = temp - 'A';
	for (it=0; it < ind; it++)
	{
		if (assem_code[it].opr != '='){
			t1 = regnum;
			if (isalpha(assem_code[it].op1) && islower(assem_code[it].op1))
				printf("LD R%d,%c\n",regnum,(assem_code[it].op1));
			else if (isalpha(assem_code[it].op1))
				printf("LD R%d,R%d\n",regnum,(assem_code[it].op1));
			else
				printf("LD R%d,#%c\n",regnum,assem_code[it].op1);
			regnum++;
			t2 = regnum;
			if (isalpha(assem_code[it].op2) && islower(assem_code[it].op2))
				printf("LD R%d,%c\n",regnum,(assem_code[it].op2));
			else if (isalpha(assem_code[it].op2))
				printf("LD R%d,R%d\n",regnum,(assem_code[it].op2));
			else
				printf("LD R%d,#%c\n",regnum,assem_code[it].op2);
			regnum++;
			switch (assem_code[it].opr){
				case '+' : printf("ADD R%d, R%d, R%d\n",regnum,t1,t2);
					   break;
				case '-' : printf("SUB R%d, R%d, R%d\n",regnum,t1,t2);
					   break;
				case '*' : printf("MUL R%d, R%d, R%d\n",regnum,t1,t2);
					   break;
			}
			printf("ST R%d, R%d\n\n",regnum,assem_code[it].regstr);
		}
		else{
			printf("ST R%d, %c\n\n",assem_code[it].regstr-1,assem_code[it].op1);
		}
		temp++;
	}
}

int main(){
	printf("\nEnter the expression : ");
	yyparse();
	temp = 'A';
	printf("\n\t\t--Assembly Code\n\n");
	produceAssem();
	return 0;
}

int yyerror(){
	printf("\nInvalid use lower case\n");
	exit(0);
}
