#ifndef _yy_defines_h_
#define _yy_defines_h_

#define N_S_D 257
#define S_D 258
#define MPY 259
#define PLUS 260
#define L_BR 261
#define R_BR 262
#define COMM 263
#define LINE_END 264
#define NUMBER 265
#ifdef YYSTYPE
#undef  YYSTYPE_IS_DECLARED
#define YYSTYPE_IS_DECLARED 1
#endif
#ifndef YYSTYPE_IS_DECLARED
#define YYSTYPE_IS_DECLARED 1
typedef union YYSTYPE {
    int integer;
} YYSTYPE;
#endif /* !YYSTYPE_IS_DECLARED */
extern YYSTYPE yylval;

#endif /* _yy_defines_h_ */
