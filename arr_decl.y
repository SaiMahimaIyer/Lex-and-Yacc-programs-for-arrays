%token INTEGER VARIABLE TYPE

%{
 #include<stdio.h>
 void yyerror(char *);  
 int yylex(void);
 int sym[50];
 int res;
%}
%left '+' '-'
%left '*' '/'
%%
program:
 program statement   '\n' 
 |
 ;
statement:
 |VARIABLE '=' VARIABLE '(' INTEGER ')' { res =sym[$5] ;}
 |VARIABLE '(' INTEGER ')' { printf("%d\n", sym[$3]); }
 | VARIABLE '(' INTEGER ')' '=' INTEGER { sym[$3] = $6; }
 |VARIABLE { printf("%d\n", res);}
 | TYPE VARIABLE'('INTEGER')'  {  }
 
 |VARIABLE '=' VARIABLE '(' INTEGER ')' '+' VARIABLE '(' INTEGER ')'  { res =sym[$5]+sym[$10] ;}
 |VARIABLE '=' VARIABLE '(' INTEGER ')' '+' VARIABLE  { res =sym[$5]+res ;}
 |VARIABLE '=' VARIABLE  '+' VARIABLE '(' INTEGER ')'  { res =sym[$7]+res ;}
 
 |VARIABLE '=' VARIABLE '(' INTEGER ')' '-' VARIABLE '(' INTEGER ')'  { res =sym[$5]-sym[$10] ;}
 |VARIABLE '=' VARIABLE '(' INTEGER ')' '-' VARIABLE  { res =sym[$5]-res ;}
 |VARIABLE '=' VARIABLE  '-' VARIABLE '(' INTEGER ')'  { res =res-sym[$7] ;}
 
 |VARIABLE '=' VARIABLE '(' INTEGER ')' '*' VARIABLE '(' INTEGER ')'  { res = (sym[$5]) * (sym[$10]) ;}
 |VARIABLE '=' VARIABLE '(' INTEGER ')' '*' VARIABLE  { res =sym[$5]*res ;}
 |VARIABLE '=' VARIABLE  '*' VARIABLE '(' INTEGER ')'  { res =sym[$7]*res ;}
 
 |VARIABLE '=' VARIABLE '(' INTEGER ')' '/' VARIABLE '(' INTEGER ')'  { if(sym[$10]==0)
                                                                           printf("divide by zero error!");
																		   else res =sym[$5]/sym[$10] ;}
 |VARIABLE '=' VARIABLE '(' INTEGER ')' '/' VARIABLE  { if(res==0)
                                                        printf("divide by zero error!");
							                            else res =sym[$5]/res ;}
 |VARIABLE '=' VARIABLE  '/' VARIABLE '(' INTEGER ')'  { if(sym[$7]==0)
                                                         printf("divide by zero error!");
									                     else res =sym[$7] ;}
 ;  

%%
void yyerror(char *s) {
 
}

int main(void) {
 yyparse();
 return 0;
} 