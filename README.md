This is a compiler of a toy language called cucu. 
It uses **Lex** and **Yacc** to parse the text file and then catogerize them as tokens and then by the definition of language, mark them syntacticallly correct or not.

I have used mathematical operators and control statements along with data types as tokens.

Use the commands to compile the compiler : 
* Step 1 : `bison -d cucu.y`
* Step 2 : `flex cucu.l`
* Step 3 : `g++ cucu.tab.c lex.yy.c -lfl -o cucu`


# Command to compile and run cucu code file 
`./cucu [FILENAME.cu]`
                
Another file Lexer.txt and parser.txt will be created
