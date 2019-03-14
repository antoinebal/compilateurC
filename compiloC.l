%{
#include "y.tab.h"
%}
%%
[" "|"\t"|"\n"] {}
"main" {return tMAIN;}
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
[a-zA-Z][a-zA-Z0-9_]* {return tID;}
[0-9]+ {return tNB;}
. {printf("error\n");}
