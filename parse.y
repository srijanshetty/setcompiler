%{
#include <stdio.h>
#include <string.h>

//Initializing the arrays  
int	set[10][21];
int i;
int set_count=0;
%}

%token  NUMBER  
%token  UNION NOT MINUS INTERSECTION OPARAN EPARAN UNIVERSE

%right MINUS
%left UNION 
%left INTERSECTION
%left NOT
%left OPARAN EPARAN

%%

SETS: OPARAN SETS EPARAN	  		{
										$$=$2;
									}

	| SET 							{
										$$=$1;
									}

	| NOT SETS 						{	//Printing the first set
										printf("\nNOT {");
										i=1;
										while(i<=20){
											if(set[$2][i]==1)
												printf("%d,",i);
											++i;	
										}
										printf("\b} = ");

										i=1;
										printf("{");
										while(i<=20){
											if(set[$2][i]==1)
												set[$2][i]=0;
											else{
												set[$2][i]=1;
												printf("%d,",i);
											}
											++i;
										}
										printf("\b}");
										$$=$2;
									}

	| SETS UNION SETS 				{
										//Printing the first set
										printf("\n{");
										i=1;
										while(i<=20){
											if(set[$1][i]==1)
												printf("%d,",i);
											++i;
										}
										printf("\b} ");

										printf("UNION ");
										
										//Printing the second set
										printf("{");
										i=1;
										while(i<=20){
											if(set[$3][i]==1)
												printf("%d,",i);
											++i;	
										}
										printf("\b} = ");
										
										i=1;
										printf("{");
										while(i<=20){
											if(set[$1][i]==1)
												printf("%d,",i);
											else if(set[$3][i]==1){
												set[$1][i]=1;
												printf("%d,",i);
											}
											++i;
										}
										printf("\b}");
										$$=$1;
									}

	| SETS INTERSECTION SETS		{
										//Printing the first set
										printf("\n{");
										i=1;
										while(i<=20){
											if(set[$1][i]==1)
												printf("%d,",i);
											++i;	
										}
										printf("\b} ");

										printf("INTERSECTION ");
										
										//Printing the second set
										printf("{");
										i=1;
										while(i<=20){
											if(set[$3][i]==1)
												printf("%d,",i);
											++i;	
										}
										printf("\b} = ");

										i=1;
										printf("{");
										while(i<=20){
											if(set[$1][i]==1 & set[$3][i]==1){
												set[$1][i]=1;
												printf("%d,",i);
											}
											else
												set[$1][i]=0;
											++i;
										}
										printf("\b}");
										$$=$1;
									}
									| SETS MINUS SETS 				{
										//Printing the first set
										printf("\n{");
										i=1;
										while(i<=20){
											if(set[$1][i]==1)
												printf("%d,",i);
											++i;	
										}
										printf("\b} ");

										printf("MINUS ");
										
										//Printing the second set
										printf("{");
										i=1;
										while(i<=20){
											if(set[$3][i]==1)
												printf("%d,",i);
											++i;	
										}
										printf("\b} = ");
										
										i=1;
										printf("{");
										while(i<=20){
											if(set[$3][i]==1)
												set[$1][i]=0;
											if(set[$1][i]==1)
												printf("%d,",i);
											++i;
										}
										printf("\b}");
										$$=$1;
									}
	; 

SET:UNIVERSE						{
										i=1;
										while(i<=20){
											set[set_count][i]=1;
											++i;	
										}
										$$=set_count;
										++set_count;
									}

	| '{' NUMBER 					{
										set[set_count][$2]=1;
										$$=set_count;
									}

	| SET ',' NUMBER 				{
										set[set_count][$3]=1;
										$$=set_count;
									}

	| SET '}'						{
										$$=set_count;
										++set_count;
									}
	;


%%

void yyerror(const char *str)
{
}
 
int yywrap()
{
        return 1;
} 

main()
{
        int m=0;
        int n=0;
        for(;m<10;m++)
        	for(;n<=20;n++)
        		set[m][n]=0;
        yyparse();
} 