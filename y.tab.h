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
    tMAIN = 258,
    tACCO = 259,
    tACCF = 260,
    tCONST = 261,
    tPARO = 262,
    tPARF = 263,
    tINT = 264,
    tPRINTF = 265,
    tWHILE = 266,
    tIF = 267,
    tPLUS = 268,
    tMULT = 269,
    tMOINS = 270,
    tDIV = 271,
    tAFFECT = 272,
    tSUPEGAL = 273,
    tINFEGAL = 274,
    tSUP = 275,
    tINF = 276,
    tDIFF = 277,
    tEGAL = 278,
    tNOT = 279,
    tVIRGULE = 280,
    tRETURN = 281,
    tNB = 282,
    tNOM = 283,
    tPV = 284,
    tVOID = 285,
    tID = 286
  };
#endif
/* Tokens.  */
#define tMAIN 258
#define tACCO 259
#define tACCF 260
#define tCONST 261
#define tPARO 262
#define tPARF 263
#define tINT 264
#define tPRINTF 265
#define tWHILE 266
#define tIF 267
#define tPLUS 268
#define tMULT 269
#define tMOINS 270
#define tDIV 271
#define tAFFECT 272
#define tSUPEGAL 273
#define tINFEGAL 274
#define tSUP 275
#define tINF 276
#define tDIFF 277
#define tEGAL 278
#define tNOT 279
#define tVIRGULE 280
#define tRETURN 281
#define tNB 282
#define tNOM 283
#define tPV 284
#define tVOID 285
#define tID 286

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
