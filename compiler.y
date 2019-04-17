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

//tIFX token virtuel
%nonassoc tIFX
%nonassoc tELSE
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
//generer instruction? 
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
	| Calcul tMULT Calcul 
	{ 

	printf("tMULT\n"); 

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

	//on ajoute l'instruction MUL r0 r0 r1
	printf("MUL r0 r0 r1");	
	ajouterInstr("mul", 0, 0, 1);

	//on ajoute l'instruction : STORE getIndexCourant() r0
	//on utilise adresse j car on veut écrire par dessus
	printf("STORE %d r0", adresse_j);	
	ajouterInstr("store", adresse_j, 0);

	} 
	| Calcul tMOINS Calcul
	{ 

	printf("tMOINS\n"); 

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

	//on ajoute l'instruction SOU r0 r0 r1
	printf("SOU r0 r0 r1");	
	ajouterInstr("sou", 0, 0, 1);

	//on ajoute l'instruction : STORE getIndexCourant() r0
	//on utilise adresse j car on veut écrire par dessus
	printf("STORE %d r0", adresse_j);	
	ajouterInstr("store", adresse_j, 0);

	} 
	| Calcul tDIV Calcul
	{ 

	printf("tDIV\n");

	int i = getIndexCourant();
	int adresse_i = getAdresse(i);
	
	QU r0 r0 r1
	printf("EQU r0 r0 r1");	
	ajouterInstr("equ", 0, 0, 1);

	//on ajoute l'instruction : STORE getIndexCourant() r0
	//on utilise adresse j car on veut écrire par dessus
	printf("STORE %d r0", adresse_j);	
	ajouterInstr("store", adresse_j, 0);
	//on rajoute l'instruction dans la table d'instruction
	printf("LOAD r0 %d", adresse_i);
	ajouterInstr("load", 0, adresse_i);

	pop();
	
	int j = getIndexCourant();
	int adresse_j = getAdresse(j);
	
	//on rajoute l'instruction dans la table d'instruction
	printf("LOAD r1 %d", adresse_j);
	ajouterInstr("load", 1, adresse_j);

	//on ajoute l'instruction DIV r0 r0 r1
	printf("DIV r0 r0 r1");	
	ajouterInstr("div", 0, 0, 1);

	//on ajoute l'instruction : STORE getIndexCourant() r0
	//on utilise adresse j car on veut écrire par dessus
	printf("STORE %d r0", adresse_j);	
	ajouterInstr("store", adresse_j, 0);

	} 
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


BlocWhile : tWHILE tPARO Condition tPARF Body;

//générer instruction avec flag
//on associe la priorité de tIFX à cette règle, pour qu'elle soit moins prio que celle d'après
BlocIf : tIF tPARO Condition tPARF
{
	int derniereAdresse = getAdresse(getIndexCourant());
	
	ajoutInstr("load", 0, derniereAdresse);

	pop();

	ajoutInstr("jmpc", -1, 1); 
	//on stocke l'idx dans la tinstr de l'instr jmpc dans le tIF 
	$1 = getMemInstruction()-1;
}
 Body %prec tIFX
{
	// on remplit l'arg -1 temporaire avec le nouveau memoire_instruction (pc)
	// qui a sans doute été changé dans le Body de la règle
	getInstrAtIdx($1).arg[0]=getMemInstruction();
}
	//le if le plus près du else est le plus prioritaire

| tIF tPARO Condition tPARF 
{
	int derniereAdresse = getAdresse(getIndexCourant());
	
	ajoutInstr("load", 0, derniereAdresse);

	pop();

	ajoutInstr("jmpc", -1, 1); 
	//on stocke l'idx dans la tinstr de l'instr jmpc dans le tIF 
	$1 = getMemInstruction()-1;
}
Body 
{
	// on remplit l'arg -1 temporaire avec le nouveau memoire_instruction (pc)
	// qui a sans doute été changé dans le Body de la règle
	getInstrAtIdx($1).arg[0]=getMemInstruction();

	// 
}
Else ;

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
Cond : Calcul tSUPEGAL Calcul 
{
	
	printf("Cond Supe\n"); 

	//les adresses des valeurs de Calcul sont forcément les deux dernières lignes de la tsymbol
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

	//on ajoute l'instruction SUPE r0 r0 r1
	printf("SUPE r0 r0 r1");	
	ajouterInstr("supe", 0, 0, 1);

	//on ajoute l'instruction : STORE getIndexCourant() r0
	//on utilise adresse j car on veut écrire par dessus
	printf("STORE %d r0", adresse_j);	
	ajouterInstr("store", adresse_j, 0);
}
| Calcul tINFEGAL Calcul | Calcul tSUP Calcul 
{
	printf("Cond\n"); 

	//les adresses des valeurs de Calcul sont forcément les deux dernières lignes de la tsymbol
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

	//on ajoute l'instruction INFE r0 r0 r1
	printf("INFE r0 r0 r1");	
	ajouterInstr("infe", 0, 0, 1);

	//on ajoute l'instruction : STORE getIndexCourant() r0
	//on utilise adresse j car on veut écrire par dessus
	printf("STORE %d r0", adresse_j);	
	ajouterInstr("store", adresse_j, 0);
}
| Calcul tINF Calcul
{
	
	printf("Cond INF\n"); 

	//les adresses des valeurs de Calcul sont forcément les deux dernières lignes de la tsymbol
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

	//on ajoute l'instruction INF r0 r0 r1
	printf("INF r0 r0 r1");	
	ajouterInstr("inf", 0, 0, 1);

	//on ajoute l'instruction : STORE getIndexCourant() r0
	//on utilise adresse j car on veut écrire par dessus
	printf("STORE %d r0", adresse_j);	
	ajouterInstr("store", adresse_j, 0);
}
 | Calcul tDIFF Calcul 
{
	
	printf("Cond DIFF\n"); 

	//les adresses des valeurs de Calcul sont forcément les deux dernières lignes de la tsymbol
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

	/*
	pour vérifier que r0 != r2 on va d'abord faire un equ
	puis comparer le résultat de ce equ avec 0 (avec equ)
	*/
	printf("EQU r0 r0 r1");	
	ajouterInstr("equ", 0, 0, 1);

	//on met 0 dans r1
	printf("AFC r1 0");
	ajouterInstr("afc", 1, 0);

	//on compare ensuite avec 0
	printf("EQU r0 r0 r1");	
	ajouterInstr("equ", 0, 0, 1);

	//(le move fr)


	//on ajoute l'instruction : STORE getIndexCourant() r0
	//on utilise adresse j car on veut écrire par dessus
	printf("STORE %d r0", adresse_j);	
	ajouterInstr("store", adresse_j, 0);
}
| Calcul tEGAL Calcul 
{	
	printf("Cond EGAL\n"); 

	//les adresses des valeurs de Calcul sont forcément les deux dernières lignes de la tsymbol
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

	//on ajoute l'instruction EQU r0 r0 r1
	printf("EQU r0 r0 r1");	
	ajouterInstr("equ", 0, 0, 1);

	//on ajoute l'instruction : STORE getIndexCourant() r0
	//on utilise adresse j car on veut écrire par dessus
	printf("STORE %d r0", adresse_j);	
	ajouterInstr("store", adresse_j, 0);
}
| Calcul;
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
