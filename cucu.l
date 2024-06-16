%{
#include <stdlib.h>
#include "cucu.tab.h"
extern YYSTYPE yylval;
void yyerror(char *s);
extern FILE *yyout,*yyin;
%}

%%    

"int"           {fprintf(yyout,"var_type : int\n");return INT;}
"char *"        {fprintf(yyout,"var_type : char\n");return CHARP;}
"if"            {fprintf(yyout,"IF : if\n");return IF;}
"char*"         {fprintf(yyout,"var_type : char\n");return CHAR;}
"else"          {fprintf(yyout,"ELSE : else\n");return ELSE;}
"return"        {fprintf(yyout,"RETURN : return\n");return RETURN;}
"while"         {fprintf(yyout,"WHILE : while\n");return WHILE;}
","             {fprintf(yyout,"COMMA : ,\n");return COMMA;}
"&"             {fprintf(yyout,"AND : &\n"); return AND;}
"|"             {fprintf(yyout,"OR: | \n"); return OR;}
"+"             {fprintf(yyout,"plus : +\n"); return PLUS;}
"-"             {fprintf(yyout,"minus : -\n"); return MINUS;}
"="             {fprintf(yyout,"ASSIGNGNMENT : =\n"); return ASSIGN;}
"("             {fprintf(yyout,"left parenthesis : ( \n"); return LPAREN;}
")"             {fprintf(yyout,"right parenthesis : ) \n"); return RPAREN;}
"<"             {fprintf(yyout,"less: < \n"); return LST;}
"/"             {fprintf(yyout,"division:  \n"); return DIV;}
">"             {fprintf(yyout,"greater : > \n"); return GRT;}
"*"             {fprintf(yyout,"ASTERISK : * \n"); return MULT;}
";"             {fprintf(yyout,"SEMICOLON : ; \n"); return SEMICOL;}
"{"             {fprintf(yyout,"LEFTBRACKET : { \n"); return LCBRACE;}
"}"             {fprintf(yyout,"RIGHTBRACKET : } \n"); return RCBRACE;}
"["             {fprintf(yyout,"leftsqr : [\n"); return LEFTSQBR;}
"]"             {fprintf(yyout,"rightsqr : ]\n"); return RIGHTSQBR;}
"<="            {fprintf(yyout,"Less than equal to : <=\n"); return LSEQ;}
"=="            {fprintf(yyout,"Equals : ==\n"); return EQ;}
"!="            {fprintf(yyout,"Not Equals : !=\n"); return NOTEQ;}
">="            {fprintf(yyout,"Greater than equal to : >=\n"); return GREQ;}
["]             {fprintf(yyout,"DOUBLEINVCOMMA : \",\n"); return DINCOMM;}
[a-zA-Z_][a-zA-Z0-9_]*   {fprintf(yyout,"ID : %s\n",yytext); return ID;}
[1-9][0-9]*              {fprintf(yyout,"NUM : %d\n",atoi(yytext)); return NUM;}
[ \t\n]+       ; 
.                        {yyerror();}

%%

int yywrap(void) {
 return 1;
}

