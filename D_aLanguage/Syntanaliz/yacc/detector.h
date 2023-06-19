//#define VERBOSE 1 
#undef VERBOSE 

#define _CPP_IOSTREAMS y



/* Define constants for patterns - used in process_pattern function */

#define PATT_NO 0 /* No pattern will be sent to parser */
#define PATT_VAL 1 /* Number detected */
#define PATT_PLUS 2 /* Plus operator */
#define PATT_MPY 3  /* Multiplication operator */
#define PATT_L_BR 4 /* Left bracket */
#define PATT_R_BR 5 /* Close bracket */
#define PATT_N_S_D 6 /* NSD operation*/
#define PATT_S_D 7 /* SD operation*/
#define PATT_COMM 8 /* Comma detected*/

#define PATT_ERR 100 /* Error in patterns: exit on errors! */


#define ERR_PATTERN 10 /* Lexer: an error pattern detected. */

char *ErrMsgMain = "Error detected with code:";

char Err_Messages[][255] = {"No Error","Lexer: Wrong character detected. Exiting."};