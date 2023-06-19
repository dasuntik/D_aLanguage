%{
/* Variable declaration */
int lines_done=0;
int void_lines_done=0;
int lines_comment=0;
int n_s_d=0;
int p_s_d=0;
int br_left=0;
int br_right=0;
int add_ops=0;
int mpy_ops=0;
int values=0;
int comma=0;
int errors_detected=0;

#include "detector.h"
#include "y.tab.h"
extern YYSTYPE yylval;


/* Function prototypes */

int process_pattern(int number, char *Message, int Pattern);
void print_error(int ERRNO);
void print_msg(char *msg);


%}

%%
^#.*\n {lines_comment=process_pattern(lines_comment,"Comment deleted.\n",PATT_NO);}
\+     {
        add_ops=process_pattern(add_ops,"Add operator detected.",PATT_PLUS);        
        return PLUS; 
        }
"NSD"  {n_s_d=process_pattern(n_s_d,"NSD detected",PATT_N_S_D);
        return N_S_D;
        }
"SD"   {p_s_d=process_pattern(p_s_d,"SD detected", PATT_S_D);
        return S_D;
        }
\,     {comma=process_pattern(comma,"Comma detected", PATT_COMM);
        return COMM;
        }
\*     {
        mpy_ops=process_pattern(mpy_ops,"Multiplication operator detected.",PATT_MPY);
        return MPY;
        }
\(     {
        br_left=process_pattern(br_left,"Opening bracket detected.",PATT_L_BR);
        return L_BR;
        }
\)     {
        br_right=process_pattern(br_right,"Closing bracket detected.", PATT_R_BR);
        return R_BR;
        } 
[1-9][0-9]* {
        values=process_pattern(values,"Number detected.", PATT_VAL); 
        yylval.integer = atoi(yytext);                 
        return NUMBER;
        }
^\n    {        
        void_lines_done++;        
        print_msg("Void line detected.\n");}       

\n     {
        lines_done++;
        print_msg("Line detected.\n");
        return LINE_END;
        }

[ \t]+ ; /*Skip whitespace*/

.      {errors_detected=process_pattern(errors_detected,"An error detected.\n",PATT_ERR);} /* What is not from alphabet: lexer error  */
%%

/* Function declaration */

int yywrap(void) {
    return 1;
}

void print_msg(char *msg){
    #ifdef VERBOSE
        printf("%s",msg);
    #endif
}

void print_error(int ERRNO){
    #ifdef VERBOSE
    char *message = Err_Messages[ERRNO];
    printf("%s - %d - %s\n",ErrMsgMain,ERR_PATTERN,message);
    #endif
}

int process_pattern(int number,char* Message, int Pattern) {
    if (Pattern == PATT_ERR) {       
        print_error(ERR_PATTERN);        
        exit(ERR_PATTERN);
    }    

    print_msg(Message);
    
    number++;
    return number;
}