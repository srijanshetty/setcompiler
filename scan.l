%{
	#include "parse.tab.h"
	int character;
%}

%%

[" "\t]			{}

[0-9]+ 			{
					if(strlen(yytext) > 1)
						yylval= 10*(yytext[0]-'0') + yytext[1]-'0'; 
					else
						yylval = yytext[0]-'0';
					return NUMBER;
				}

"minus" 		{return MINUS;}

"union" 		{return UNION;}

"intersection" 	{return INTERSECTION;}

"not" 			{return NOT;}

[\n] 			{return EOF;}

[^a-z0-9\b]    	{
             		character = yytext[0];
                 	return character;
               	}

%%
