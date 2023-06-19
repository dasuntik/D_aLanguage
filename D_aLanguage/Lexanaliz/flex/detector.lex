%{
/* Variable declaration */
int lines_done=0;
int void_lines_done=0;
int lines_comment=0;
int nejvetsi_spolecny_delitel=0;
int pocet_spolecnych_delitelu=0;
int br_left=0;
int br_right=0;
int values=0;
int comma=0;
int errors_detected=0;

#include "detector.h"

/* Function prototypes */

int process_pattern(int number, char *Message);

%}
%%
^#.*\n  {lines_comment=process_pattern(lines_comment,"Comment deleted.\n");}
\NSD   {nejvetsi_spolecny_delitel=process_pattern(nejvetsi_spolecny_delitel,"NSD detected.");}
\SD   {pocet_spolecnych_delitelu=process_pattern(pocet_spolecnych_delitelu,"SD detected.");}
\(     {br_left=process_pattern(br_left,"Opening bracket detected.");}
\)     {br_right=process_pattern(br_right,"Closing bracket detected.");} 
[1-9][0-9]* {values=process_pattern(values,"Number detected.");}
\,     {comma=process_pattern(comma,"Comma detected");}
^\n    {void_lines_done++;printf("Void line detected.\n");}
\n     {lines_done++;printf("Line detected.\n");}
.      {errors_detected=process_pattern(errors_detected,"An error detected.\n");}
%%
/* Main part */
int yywrap(){};
int main()
    {
        yylex();
        printf("%d of total errors detected in input file.\n",errors_detected);
        printf("%d of numbers detected.\n",values);
        printf("%d of comment lines canceled.\n",lines_comment);
        printf("%d of NSD detected.\n",nejvetsi_spolecny_delitel);
        printf("%d of SD detected.\n",pocet_spolecnych_delitelu);
        printf("%d of void lines ignored.\nFile processed sucessfully.\n",void_lines_done);
        printf("Totally %d of valid code lines in file processed.\nFile processed sucessfully.\n",lines_done);
        
    }

/* Function declaration */

int process_pattern(int number,char* Message) {
    #ifdef VERBOSE 
        printf("%s",Message);
    #endif
    number++;
    return number;
}