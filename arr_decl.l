%{
 #include <stdlib.h>
 void yyerror(char *); 
 #include "y.tab.h"
%}
%%
 /* variables */
[a-z] {
 yylval = *yytext;
 return VARIABLE;
 }
 /* integers */
[0-9]+ {
 yylval = atoi(yytext);
 return INTEGER;
 }
 /*datatype*/
[int|float] {yylval =*yytext; 
           return TYPE;
}
 /* operators */
[-+()=/*\n] { return *yytext; }
 /* skip whitespace */
[ \t\n] ;
%%
int yywrap(void) {
 return 1;
} 