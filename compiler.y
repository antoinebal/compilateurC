%{
	#include "tsymbol.h"
	#include "tinstr.h"	
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
Fonction : Type tID 
{
//on inclue les arguments qui ne sont visibles que dans le body de la fonction 
descendre();
} 
tPARO Arguments tPARF BodyFonction {monter();};
Type : tINT|tVOID ;
Arguments : 
Argument tVIRGULE Arguments | 
Argument | ;
Argument : tINT tID ;
//Attention on peut faire un return dans un void
BodyFonction : tACCO Declarations Actions tACCF | tACCO Declarations Actions tRETURN Calcul tPV	 tACCF; 
Declarations :  | Declaration Declarations ; 
Declaration : tINT tID tPV 
	{
	//on ajoute une ligne pour cette variable qu'on vient de déclarer
	ajouterLigne("int ",$2, 0);
	};
Actions : Action Actions |  ;
Action : Affectation | BlocIf | BlocWhile | AppelFonction | Printf ; 
Affectation : tID tAFFECT Calcul tPV; 
//cette fonction doit retourner un int

Calcul : Grandeur 
	| Calcul tPLUS Calcul 
	{ 
	printf("tPLUS\n");
	int i = getIndexCourant();
	int adresse_i = getAdresse(i);
	

	
	//on rajoute l'instruction dans la table d'instruction
	printf("LOAD r0 %d", adresse_i);
	ajouterInstr("load", 0, adresse_i);

	pop();
	
	int j = getIndexCourant();
	int adresse_j = getAdresse(j);
	
	//on rajoute l'instruction dans la table d'instruction
	printf("LOAD r1 %d", adresse_j);
	ajouterInstr("load", 1, adresse_j);

	//on ajoute l'instruction ADD r0 r0 r1
	printf("ADD r0 r0 r1");	
	ajouterInstr("add", 0, 0, 1);

	//on ajoute l'instruction : STORE getIndexCourant() r0
	//on utilise adresse j car on veut écrire par dessus
	printf("STORE %d r0", adresse_j);	
	ajouterInstr("store", adresse_j, 0);
	
	} 
	| Calcul tMULT Calcul { printf("tMULT\n"); } 
	| Calcul tMOINS Calcul { printf("tMOINS\n"); } 
	| Calcul tDIV Calcul { printf("tDIV\n"); }
	| AppelFonction | Parentheses;
Parentheses : tPARO Calcul tPARF;
Grandeur : tNB 
	{
	printf(">int> %d\n",$1);
	int ind = ajouterLigneTmp();
	int adresse = getAdresse(ind);
	int tmp = ajouterLigneTmp();
	
	//ici on va générer les instructions MOV r0 $1 ,STORE adr r0
	

	//printf("AFC r0 %d\n", $1);
	printf("AFC r0 %d\n", $1);
	ajouterInstr("afc", 0, $1);


	printf("STORE %d r0\n", getAdresse(tmp));
	ajouterInstr("store", tmp, 0);

	}
	| tID 
	{
	printf(">id> %s\n", $1);
	int ind = getIndex($1);
	int adresse = getAdresse(ind);
	int tmp = ajouterLigneTmp();

	printf("LOAD r0 %d\n", adresse);
	ajoutInstr("load", 0, adresse);
	
	printf("STORE %d, r0\n", getAdresse(tmp));
	ajoutInstr("store", tmp, 0);

	$$ = tmp;
	}
	int ;


BlocWhile : tWHILE tPARO Condition tPARF Body;

BlocIf : tIF tPARO Condition tPARF Body Else ;
Else : | tELSE BlocIf | tELSE Body ;
//body spécial qui ne permet pas les déclarations
Body : tACCO
{
	descendre();
}
Actions tACCF
{
	monter();
};
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
