#include <stdio.h>
#include<stdlib.h>
#include <string.h>
char st[100], inp[100],tmp[100];
int j=0,i=0,t=0;

void push(char item){
	st[j++] = item;
}

void dispinp(){
	int x;
	for (x=0;x<strlen(inp);x++)
		printf("%c",inp[x]);
	printf("\t\t");
}

void dispstk(){
	int x;
	printf("$");
	for (x=0;x<j;x++)
		printf("%c",st[x]);
	printf("\t\t");
}

int main(){
	int l,m;
	char op;
	printf("\n\t\tSHIFT - REDUCE PARSER\n");
	printf("\tThe Grammer is E -> E+E | E-E | E*E | i\n\n");
	printf("Enter expression : ");
	scanf("%s",inp);
	l = strlen(inp);
	inp[l++] = '$';
	inp[l] = '\0';
	printf("\nSTACK\t\tINPUT\t\tACTION\n---------------------------------\n");
	
	// Shift
	
	while (inp[i] != '$'){
		dispstk();
		dispinp();
		switch(inp[i]){ 
			case 'i' : push(inp[i]);
				   inp[i] = ' ';
				   i++;
				   printf("Shift\n");
				   break;
			
			case '+' : 
			case '-' : 
			case '*' : push(inp[i]);
				   inp[i] = ' ';
				   i++;
				   printf("Shift\n");
				   break;
			default : printf("Error\n\nInvalid Input Sequence !!\n");
				  exit(0);
		}
		// Reduce E -> i if found
		if (st[j-1] == 'i'){
			dispstk();
			dispinp();
			printf("Reduce E -> i\n");
			st[j-1] = 'E';
			continue;
		}
	}
	
	//Reductions
	
	l = j-1;
	t = 0;
	while (l >=0){
		tmp[t++] = st[l--];
		tmp[t] = '\0';
		if (!strcmp(tmp,"E+E") || !strcmp(tmp,"E-E") || !strcmp(tmp,"E*E")){
			dispstk();
			dispinp();
			st[--j] = ' '; 
			op = st[j-1]; 
			st[--j] = ' '; 

			printf("Reduce E -> E %c E\n",op);
			
			//Reinit tmp
			l=j-1;
			for (m=0;m<100;m++)
				tmp[m] = '\0';
			t=0;
		}
	}

	// Check
	dispstk();
	dispinp();
	if (st[j] == 'E' || (j == 1 && st[j-1] == 'E')){
		printf("Accept\n\n");
	}
	else{
		printf("Error\n\nInvalid Input Sequence !!");
		exit(0);
	}
	return 0;
}
