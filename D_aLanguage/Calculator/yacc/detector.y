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
#include <math.h>


int yylex();
void yyerror(const char *s);
extern int yylineno;
int is_prime(int a);
int gcd(int a, int b);
int gcd_3(int a, int b, int c);
int count_common_divisors(int a, int b);
int count_common_divisors_3(int a, int b, int c);
double sqrt_custom(double number);
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
        int a = $1;
        printf("Syntax OK, basic expr\n");
        printf("Result: %d\n\n", a);
        if (is_prime(a)) {
        printf("%d is a prime number.\n\n", a);
        } else {
        printf("%d is not a prime number.\n\n", a);
    }
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
    N_S_D L_BR expr R_BR { printf("Syntax OK,\n");
                            printf("GCD: %d\n\n", $3); } 
    | S_D L_BR expr R_BR { printf("Syntax OK, \n");
                            printf("Common Divisors Count: %d\n\n", $3); } 
    ;

expr: 
    NUMBER COMM NUMBER COMM NUMBER { $$ = count_common_divisors_3($1, $3, $5); 
                if (is_prime($1) || is_prime($3) || is_prime($5)) {
                printf("At least one of %d, %d, and %d is a prime number.\n", $1, $3, $5);
                } else {
                printf("None of %d, %d, and %d are prime numbers.\n", $1, $3, $5);
    }
    
    }
    | NUMBER COMM NUMBER COMM NUMBER { $$ = gcd_3($1, $3, $5); }
    | NUMBER COMM NUMBER { $$ = gcd($1, $3); 
            if (is_prime($1) || is_prime($3)) {
            printf("%d and/or %d is a prime number.\n", $1, $3);
            } else {
            printf("Neither %d nor %d are prime numbers.\n", $1, $3);
            }}
    | NUMBER COMM NUMBER { $$ = count_common_divisors($1, $3); }
%%

void yyerror(const char* s) {   
    printf("%s\n", s);
}

int is_prime(int a) {
    if (a <= 1) return 0; // 0 and 1 are not prime numbers
    if (a == 2) return 1; // 2 is a prime number
    if (a % 2 == 0) return 0; // All other even numbers are not primes
    for(int i = 3; i <= sqrt_custom(a); i+=2) {
        if (a % i == 0 )
            return 0;
    }
    return 1;
}

int gcd(int a, int b) {

    if (b == 0) {
        return a;
    }
    return gcd(b, a % b);
}

int gcd_3(int a, int b, int c) {
    // Check if a, b or c is prime
    if (is_prime(a) || is_prime(b) || is_prime(c)) {
        printf("At least one of %d, %d, and %d is a prime number.\n", a, b, c);
    } else {
        printf("None of %d, %d, and %d are prime numbers.\n", a, b, c);
    }

    // Compute the gcd
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

double sqrt_custom(double number) {
    double error = 1e-7; // Define the precision of your answer
    double s = number;

    while ((s - number / s) > error) {
        s = (s + number / s) / 2;
    }

    return s;
}

int main() {
    yyparse();
    return 0;
}
