%{
	#include "tsymbol.h"	
	int yylex(void);
	void yyerror(char*);
%}

%token tACCO tACCF tCONST tPARO tPARF tINT tPRINTF tWHILE tIF tPLUS tMULT tMOINS tDIV tAFFECT tSUPEGAL tINFEGAL tSUP tINF tDIFF tEGAL tNOT tVIRGULE tRETURN tNB tNOM tPV tVOID tID tELSE

%left tPLUS tMOINS
%left tMULT tDIV


%union {
	int e;
	char* e2;
} 

%type <e2> tID
%type <e> tNB 

//%type <e2> Operateur


%%


start : Fonctions;
Fonctions : Fonction Fonctions | Fonction ;
Fonction : Type tID tPARO Arguments tPARF BodyFonction ;
Type : tINT|tVOID ;
Arguments : Argument tVIRGULE Arguments | Argument | ;
Argument : tINT tID ;
//Attention on peut faire un return dans un void
BodyFonction : tACCO Declarations Actions tACCF | tACCO Declarations Actions tRETURN Calcul tPV	 tACCF; 
Declarations :  | Declaration Declarations ; 
Declaration : tINT tID tPV ;
Actions : Action Actions |  ;
Action : Affectation | BlocIf | BlocWhile | AppelFonction | Printf ; 
Affectation : tID tAFFECT Calcul tPV; 
//cette fonction doit retourner un int

Calcul : Grandeur | Calcul tPLUS Calcul { printf("tPLUS\n"); } | Calcul tMULT Calcul { printf("tMULT\n"); } | Calcul tMOINS Calcul { printf("tMOINS\n"); } | Calcul tDIV Calcul { printf("tDIV\n"); }| AppelFonction | Parentheses;
Parentheses : tPARO Calcul tPARF;
Grandeur : tNB 
	{
	int index = ajouterLigneTmp();
	int adresse = getAdresse(index);
	//ici on va générer les instructions MOV r0 $1 ,STORE adr r0
	}
	| tID;


BlocWhile : tWHILE tPARO Condition tPARF Body;

BlocIf : tIF tPARO Condition tPARF Body Else ;
Else : | tELSE BlocIf | tELSE Body ;
//body spécial qui ne permet pas les déclarations
Body : tACCO Actions tACCF ;
Condition : Cond | tNOT Cond ;
Cond : Calcul tSUPEGAL Calcul | Calcul tINFEGAL Calcul | Calcul tSUP Calcul |
Calcul tINF Calcul | Calcul tDIFF Calcul | Calcul tEGAL Calcul | Calcul;
//cette fonction doit être void
AppelFonction : tID tPARO Args tPARF tPV;
//même chose que dans la déclaration des fonctions mais sans les types
Args : Calcul tVIRGULE Args | Calcul | ; 
//pour l'instant on peut print que des int
Printf : tPRINTF tPARO Calcul tPARF tPV ;
 

%%

int main(void) {
#ifdef YYDEBUG
	yydebug = 1;
#endif
	yyparse();
}
