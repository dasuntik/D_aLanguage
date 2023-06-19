%{
/* Original EBNF 
syntax = basic | action;
basic = number, {oper, number};
oper = add | multiply;
action = NSD | SD;
NSD = 'NSD', expression;
SD = 'SD', expression;
expression = '(', number, comma, number, {comma, number}, ')';
comma = ',';
multiply = '*';
add = '+';
number = firstdigit, {digit};
digit = ’0’ | ’1’ | ’2’ | ’3’ | ’4’ | ’5’ | ’6’ | ’7’ | ’8’ | ’9’;
firstdigit = ’1’ | ’2’ | ’3’ | ’4’ | ’5’ | ’6’ | ’7’ | ’8’ | ’9’;
*/

#include <stdio.h>
#include <stdlib.h>
#include "inc/prints.h"
#include "inc/prk-stack.h"

int yylex();
void yyerror(const char *s);
extern int yylineno;



%}

%token N_S_D
%token S_D
%token MPY
%token PLUS
%token L_BR
%token R_BR
%token COMM
%token NUMBER
%token LINE_END

%%
Lang:
    expr
    | Lang expr
    | error LINE_END { yyerror("Syntax error"); }
    ;

expr:
    basic LINE_END { debug_print("Syntax OK, basic expression\n"); }
    | action LINE_END { debug_print("Syntax OK, action\n"); }
    ;
basic:
    value oper basic { debug_print("basic expression\n"); }
    | value { debug_print("number\n"); }
    ;
value:
    
    NUMBER { debug_print("Some digits"); }
    ;

oper:
    PLUS { debug_print("add"); }
    | MPY { debug_print("multiply"); }
    ;

action:
    N_S_D expression { debug_print("NSD action\n"); }
    | S_D expression { debug_print("SD action\n"); }
    ;

expression:
    L_BR value comma value R_BR { debug_print("expression\n"); }
    |L_BR value comma value expression_list R_BR { debug_print("expression with 3 meanings\n"); }
    ;

expression_list:
    comma value { debug_print("3rd meaning\n"); }
    ;

comma:
    COMM { printf("comma\n"); }
    ;
%%

void yyerror(const char* s) {   
    printf("%s\n", s);
}


int main(){
    //yydebug = 1;
    debug_print("Entering the main");
    yyparse();
    
    return 0;
}