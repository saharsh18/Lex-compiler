%{
#include<stdio.h>

extern FILE *yyin,*yyout;
extern char *yytext;
FILE *yparse;
int yylex();
void yyerror(char *s) {fprintf(yyout,"ERROR \n");}

%}

%token INT CHARP IF ELSE WHILE RETURN ASSIGN SEMICOL AND OR PLUS MINUS MULT DIV LPAREN RPAREN LCBRACE RCBRACE LEFTSQBR RIGHTSQBR LST GRT EQ GREQ LSEQ NOTEQ COMMA DINCOMM ID NUM   

%%

stmts :	stmt 
	| stmts stmt
	;
stmt :	exp SEMICOL		{fprintf(yparse,"exp : \n");}
	| var_dec SEMICOL	{fprintf(yparse,"var_declaration : \n");}
	| func
	| Ctrl_stmt
	;
	
Ctrl_stmt :  ifStmt		{fprintf(yparse,"if_statement  \n");}
	| whileStmt		{fprintf(yparse,"while_statement \n");}
	;
	
whileStmt :	WHILE LPAREN exp RPAREN stmt				{fprintf(yparse,"while_statement\n");} 
		| WHILE LPAREN exp RPAREN LCBRACE funcbody  RCBRACE	{fprintf(yparse,"while_statement\n");} 
		;
		
ifStmt :	IF LPAREN exp RPAREN stmt			{fprintf(yparse,"if_statement\n");} 
		| IF LPAREN exp RPAREN LCBRACE funcbody  RCBRACE	{fprintf(yparse,"if_statement\n");} 
		;

func :  fun_dec SEMICOL		{fprintf(yparse,"func_declaration : \n");}
	| functionDef 		{fprintf(yparse,"func_definition : \n");}
	| functionCall SEMICOL	{fprintf(yparse,"func_call : \n");}
	;
	
funcbody : 	stmts  
		;

exp : 	bool_exp
	| assignment			{fprintf(yparse,"assign_expr \n");}
	| equation			{fprintf(yparse,"simple_expression \n");}
	;
	

bool_exp : equation EQ equation 		{	fprintf(yparse,"bool_expr \n");}
	| equation NOTEQ equation 		{fprintf(yparse,"bool_expr \n");}
	;
	
dataType :	INT		{fprintf(yparse,"var_type int \n");}
		| CHARP		{fprintf(yparse,"var_type char_pointer \n");}
		;

data :	NUM				{fprintf(yparse,"const_number  \n");}
	| ID				{fprintf(yparse,"variable  \n");}
	| ID LEFTSQBR exp RIGHTSQBR	{fprintf(yparse,"variable  \n");}
	;
		
assignment :	ID ASSIGN equation	{fprintf(yparse,"variable  = \n");}
		;
		
equation :	equation PLUS term			{fprintf(yparse,"arith_operator : + \n");}
	| equation MINUS term		{fprintf(yparse,"arith_operator :  - \n");}
	| term
	;
	
term : 	term MULT factor		{fprintf(yparse,"operator :  * \n");}
	| term DIV factor		{fprintf(yparse,"operator :  / \n");}
	| factor
	;
	
factor :	LPAREN equation RPAREN
		| data
		;

id_list :	ID 			{fprintf(yparse,"variable \n");}
		| ID COMMA id_list
		;
		
ass_list :	assignment 
		| assignment COMMA assignment
		;	

		
var_dec :	dataType id_list
		| dataType ass_list
		;
		
fun_dec :	dataType ID LPAREN arglist  RPAREN		{fprintf(yparse,"func_definition\n");} 
		| dataType ID LPAREN RPAREN 			{fprintf(yparse,"func_definition\n");} 
		;
		
exp_list : 	exp
		| exp COMMA exp_list
		;
		
functionCall : 	ID LPAREN exp_list RPAREN 	{fprintf(yparse,"func_call\n");} 
		| ID LPAREN RPAREN		{fprintf(yparse,"func_call\n");} 
		|
		;
		
arglist  :	dataType ID
		| dataType ID COMMA arglist 
		;
		
functionDef  : 	dataType ID LPAREN arglist  RPAREN LCBRACE funcbody RETURN exp SEMICOL RCBRACE		{fprintf(yparse,"func_end\n");} 
		| dataType ID LPAREN RPAREN LCBRACE funcbody RETURN exp SEMICOL RCBRACE			{fprintf(yparse,"func_end\n");} 
		;
		



		
%%



int main(){
    yyin = fopen("sample1.cu","r");
    yparse = fopen("Parser.txt","w");
    yyout = fopen("Lexer.txt","w");
    yyparse();
    return 0;
}