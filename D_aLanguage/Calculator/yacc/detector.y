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


int yylex();
void yyerror(const char *s);
extern int yylineno;
int gcd(int a, int b);
int gcd_3(int a, int b, int c);
int count_common_divisors(int a, int b);
int count_common_divisors_3(int a, int b, int c);
%}

%token N_S_D
%token S_D
%token MPY
%token PLUS
%token L_BR
%token R_BR
%token COMM
%token LINE_END

%union {
    int integer;
}

%token<integer> NUMBER
%type<integer> expr action value basic

%%
Lang:
    | Lang expression
    | expression
    ;

expression:
    basic LINE_END { 
        printf("Syntax OK, basic expr\n");
        printf("Result: %d\n\n", $1);
        }
    | action LINE_END
    ;

basic:
    value
    | basic PLUS value {
        $$ = $1 + $3;
        }
    | basic MPY value {
        $$ = $1 * $3;
        }
    ;

value:
    NUMBER {
        $$ = $1;
        }
    ;

action: 
    N_S_D L_BR expr R_BR { printf("Syntax OK,");
                            printf("GCD: %d\n\n", $3); } 
    | S_D L_BR expr R_BR { printf("Syntax OK, \n");
                            printf("Common Divisors Count: %d\n\n", $3); } 
    ;

expr: 
    NUMBER COMM NUMBER COMM NUMBER { $$ = count_common_divisors_3($1, $3, $5); }
    | NUMBER COMM NUMBER COMM NUMBER { $$ = gcd_3($1, $3, $5); }
    | NUMBER COMM NUMBER { $$ = gcd($1, $3); }
    | NUMBER COMM NUMBER { $$ = count_common_divisors($1, $3); }
%%

void yyerror(const char* s) {   
    printf("%s\n", s);
}

int gcd(int a, int b) {
    if (b == 0) {
        return a;
    }
    return gcd(b, a % b);
}

int gcd_3(int a, int b, int c) {
    return gcd(gcd(a, b), c);
}

int count_common_divisors(int a, int b) {
    int count = 0;
    int minVal = a < b ? a : b;
    for (int i = 1; i <= minVal; i++) {
        if (a % i == 0 && b % i == 0) {
            count++;
        }
    }
    return count;
}
int count_common_divisors_3(int a, int b, int c) {
    int count = 0;
    int minVal = (a < b) ? ((a < c) ? a : c) : ((b < c) ? b : c);
    for (int i = 1; i <= minVal; i++) {
        if (a % i == 0 && b % i == 0 && c % i == 0) {
            count++;
        }
    }
    return count;
}
int main() {
    yyparse();
    return 0;
}
