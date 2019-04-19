/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 1
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    tACCO = 258,
    tACCF = 259,
    tCONST = 260,
    tPARO = 261,
    tPARF = 262,
    tINT = 263,
    tPRINTF = 264,
    tWHILE = 265,
    tIF = 266,
    tPLUS = 267,
    tMULT = 268,
    tMOINS = 269,
    tDIV = 270,
    tAFFECT = 271,
    tSUPEGAL = 272,
    tINFEGAL = 273,
    tSUP = 274,
    tINF = 275,
    tDIFF = 276,
    tEGAL = 277,
    tNOT = 278,
    tVIRGULE = 279,
    tRETURN = 280,
    tNB = 281,
    tNOM = 282,
    tPV = 283,
    tVOID = 284,
    tID = 285,
    tELSE = 286,
    tIFX = 287
  };
#endif
/* Tokens.  */
#define tACCO 258
#define tACCF 259
#define tCONST 260
#define tPARO 261
#define tPARF 262
#define tINT 263
#define tPRINTF 264
#define tWHILE 265
#define tIF 266
#define tPLUS 267
#define tMULT 268
#define tMOINS 269
#define tDIV 270
#define tAFFECT 271
#define tSUPEGAL 272
#define tINFEGAL 273
#define tSUP 274
#define tINF 275
#define tDIFF 276
#define tEGAL 277
#define tNOT 278
#define tVIRGULE 279
#define tRETURN 280
#define tNB 281
#define tNOM 282
#define tPV 283
#define tVOID 284
#define tID 285
#define tELSE 286
#define tIFX 287

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 14 "compiler.y" /* yacc.c:1909  */

	int e;
	char* e2;

#line 123 "y.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
