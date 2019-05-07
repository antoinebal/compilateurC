%{
#include "y.tab.h"
%}
%%
[" "|"\t"|"\n"] {}
"{" {return tACCO;}
"}" {return tACCF;}
"const" {return tCONST;}
"(" {return tPARO;}
")" {return tPARF;}
"int" {return tINT;}
"printf" {return tPRINTF;}
"while" {return tWHILE;}
"void" {return tVOID;} 
"if" {return tIF;}
"else" {return tELSE;}
"+" {return tPLUS;}
"*" {return tMULT;}
"-" {return tMOINS;}
"/" {return tDIV;}
"=" {return tAFFECT;}
">=" {return tSUPEGAL;}
"<=" {return tINFEGAL;}
">" {return tSUP;}
"<" {return tINF;}
"!=" {return tDIFF;}
"==" {return tEGAL;}
"!" {return tNOT;}
"," {return tVIRGULE;}
"return" {return tRETURN;}
";" {return tPV;}
[a-zA-Z][a-zA-Z0-9_]* {yylval.e2 = strdup(yytext); return tID;}
[0-9]+ {yylval.e = atoi(yytext); return tNB;}
. {printf("error\n");}
