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
%type <e> Grandeur;
%type <e> tWHILE;
%type <e> tIF;


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

//arguments dans la déf d'une fonction
Arguments : 
Argument tVIRGULE Arguments | 
Argument | ;

Argument : tINT tID ;

//Attention on peut faire un return dans un void
/*Un body de fonction obligatoirement de la forme : 
	{
		declarations
		actions
		(return Calcul)
	}
*/
BodyFonction : tACCO Declarations Actions tACCF | tACCO Declarations Actions tRETURN Calcul tPV	 tACCF;


Declarations :  | Declaration Declarations ;
/*
nous n'autorisons pas les déclarations 2en1 (décla et affectation)
du type : int a = 1;
*/
Declaration : tINT tID tPV 
	{
	//on ajoute une ligne dans ts pour cette variable qu'on vient de déclarer
	ajouterLigneTS("int ",$2, 0);
	};

Actions : Action Actions |  ;
Action : Affectation | BlocIf | BlocWhile | AppelFonction | Printf ; 


Affectation : tID tAFFECT Calcul tPV
/*
on génère : 
	load r1 derniereAdresseTS
	cop r0 r1
	store adresse_tID r0
*/
{
	printf("Affectation");

	//on récup la dernière valeur dans ts
	int i = getIndexCourantTS();
	int adresse_i = getAdresseTS(i);
	popTS();

	//on récup l'adresse de tID
	int idx_tID = getIndexTS($1);
	int adresse_tID = getAdresseTS(idx_tID);

	//on load la dernière valeur de ts récupérée dans r1
	printf("LOAD r1 %d", adresse_i);
	ajouterInstr2("load", 1, adresse_i);

	//on cop r1 dans r0
	printf("COP r0 r1");
	ajouterInstr2("cop", 0, 1);

	//on store la nouvelle valeur (dans r0) à l'adresse de tID
	printf("STORE %d 0", adresse_tID);
	ajouterInstr2("store", adresse_tID, 0);
}; 

Calcul : Grandeur 
	| Calcul tPLUS Calcul 
/*
on génère : 
	load r0 derniereAdresseTS
	load r1 avantDerniereAdresseTS
	add r0 r0 r1
	store avantDerniereAdresseTS r0
*/
	{ 
	printf("tPLUS\n");
	int i = getIndexCourantTS();
	int adresse_i = getAdresseTS(i);
		
	//on rajoute l'instruction dans la table d'instruction
	printf("LOAD r0 %d", adresse_i);
	ajouterInstr2("load", 0, adresse_i);

	popTS();
	
	int j = getIndexCourantTS();
	int adresse_j = getAdresseTS(j);
	
	//on rajoute l'instruction dans la table d'instruction
	printf("LOAD r1 %d", adresse_j);
	ajouterInstr2("load", 1, adresse_j);

	//on ajoute l'instruction ADD r0 r0 r1
	printf("ADD r0 r0 r1");	
	ajouterInstr3("add", 0, 0, 1);

	//on ajoute l'instruction : STORE getIndexCourantTS() r0
	//on utilise adresse j car on veut écrire par dessus et elle est en haut de ts
	printf("STORE %d r0", adresse_j);	
	ajouterInstr2("store", adresse_j, 0);
	
	} 
	| Calcul tMULT Calcul 

/*
on génère : 
	load r0 derniereAdresseTS
	load r1 avantDerniereAdresseTS
	mult r0 r0 r1
	store avantDerniereAdresseTS r0
*/
	{ 

	printf("tMULT\n"); 

	int i = getIndexCourantTS();
	int adresse_i = getAdresseTS(i);
		
	//on rajoute l'instruction dans la table d'instruction
	printf("LOAD r0 %d", adresse_i);
	ajouterInstr2("load", 0, adresse_i);

	popTS();
	
	int j = getIndexCourantTS();
	int adresse_j = getAdresseTS(j);
	
	//on rajoute l'instruction dans la table d'instruction
	printf("LOAD r1 %d", adresse_j);
	ajouterInstr2("load", 1, adresse_j);

	//on ajoute l'instruction MUL r0 r0 r1
	printf("MUL r0 r0 r1");	
	ajouterInstr3("mul", 0, 0, 1);

	//on ajoute l'instruction : STORE getIndexCourantTS() r0
	//on utilise adresse j car on veut écrire par dessus
	printf("STORE %d r0", adresse_j);	
	ajouterInstr2("store", adresse_j, 0);

	} 
	| Calcul tMOINS Calcul
	
/*
on génère : 
	load r0 derniereAdresseTS
	load r1 avantDerniereAdresseTS
	sou r0 r0 r1
	store avantDerniereAdresseTS r0
*/
	{ 
	printf("tMOINS\n"); 

	int i = getIndexCourantTS();
	int adresse_i = getAdresseTS(i);	
	
	//on rajoute l'instruction dans la table d'instruction
	printf("LOAD r0 %d", adresse_i);
	ajouterInstr2("load", 0, adresse_i);

	popTS();
	
	int j = getIndexCourantTS();
	int adresse_j = getAdresseTS(j);
	
	//on rajoute l'instruction dans la table d'instruction
	printf("LOAD r1 %d", adresse_j);
	ajouterInstr2("load", 1, adresse_j);

	//on ajoute l'instruction SOU r0 r0 r1
	printf("SOU r0 r0 r1");	
	ajouterInstr3("sou", 0, 0, 1);

	//on ajoute l'instruction : STORE getIndexCourantTS() r0
	//on utilise adresse j car on veut écrire par dessus
	printf("STORE %d r0", adresse_j);	
	ajouterInstr2("store", adresse_j, 0);

	} 
	| Calcul tDIV Calcul
	
/*
on génère : 
	load r0 derniereAdresseTS
	load r1 avantDerniereAdresseTS
	div r0 r0 r1
	store avantDerniereAdresseTS r0
*/
{ 
	printf("tDIV\n"); 

	int i = getIndexCourantTS();
	int adresse_i = getAdresseTS(i);
	
	//on rajoute l'instruction dans la table d'instruction
	printf("LOAD r0 %d", adresse_i);
	ajouterInstr2("load", 0, adresse_i);

	popTS();
	
	int j = getIndexCourantTS();
	int adresse_j = getAdresseTS(j);
	
	//on rajoute l'instruction dans la table d'instruction
	printf("LOAD r1 %d", adresse_j);
	ajouterInstr2("load", 1, adresse_j);

	//on ajoute l'instruction DIV r0 r0 r1
	printf("DIV r0 r0 r1");	
	ajouterInstr3("div", 0, 0, 1);

	//on ajoute l'instruction : STORE getIndexCourantTS() r0
	//on utilise adresse j car on veut écrire par dessus
	printf("STORE %d r0", adresse_j);	
	ajouterInstr2("store", adresse_j, 0);

	} 
	| AppelFonction | Parentheses;
Parentheses : tPARO Calcul tPARF;


Grandeur : tNB 
/*
on génère : 
	afc r0 tNB
	store derniereAdresseTS r0
*/
	{
	printf(">int> %d\n",$1);
	int ind = ajouterLigneTmpTS();
	int adresse = getAdresseTS(ind);
	int tmp = ajouterLigneTmpTS();
	
	//ici on va générer les instructions MOV r0 $1 ,STORE adr r0
	
	//printf("AFC r0 %d\n", $1);
	printf("AFC r0 %d\n", $1);
	ajouterInstr2("afc", 0, $1);

	printf("STORE %d r0\n", getAdresseTS(tmp));
	ajouterInstr2("store", tmp, 0);

	}
	| tID
/*
on génère : 
	load r0 adressetID
	store derniereAdresseTS r0
*/ 
	{
	printf(">id> %s\n", $1);
	int ind = getIndexTS($1);
	int adresse = getAdresseTS(ind);
	int tmp = ajouterLigneTmpTS();

	printf("LOAD r0 %d\n", adresse);
	ajouterInstr2("load", 0, adresse);
	
	printf("STORE %d, r0\n", getAdresseTS(tmp));
	ajouterInstr2("store", tmp, 0);

	//utile?
	$$ = tmp;
	}


BlocWhile : tWHILE tPARO
/*
on génère : 
	@1 : load r1 derniereAdresse (contenant le résultat de la cond, 0 ou 1)
	@2 : jmpc @N+1 r1
	Body
	@N : jmp @1
*/
{
	//<e> utile pour spécifier le type
	$<e>2=getMemInstruction();
}
 Condition tPARF 
{
	//si la condition n'est pas bonne on saute direct à la fin
	int derniereAdresse = getAdresseTS(getIndexCourantTS());

	//on récupère la dernière condition stockée
	ajouterInstr2("load", 1, derniereAdresse);
	popTS();
	//-1 sera à remplacer par l'adr, on saute si r1=0, soit si cond fausse
	ajouterInstr2("jmpc", -1, 1); 
	//on stocke l'idx dans la tinstr de l'instr jmpc dans le tWHILE 
	$1 = getMemInstruction()-1;
}
Body
{
	//on ajoute un jump dans tous les cas avant le jmpc
	ajouterInstr1("jmp", $<e>2);

	// on remplit l'arg -1 temporaire avec le nouveau memoire_instruction (pc)
	// qui a sans doute été changé dans le Body de la règle et avec l'inst jmp juste avant
	getInstrAtIdx($1).arg[0]=getMemInstruction();
}
;

//générer instruction avec flag
//on associe la priorité de tIFX à cette règle, pour qu'elle soit moins prio que celle d'après
//règle : BlocIf : tIF tPARO Condition tPARF
BlocIf : tIF tPARO Condition tPARF %prec tIFX
/*
on génère : 
	load r1 derniereAdresseTS (contenant le rés de la condition, 0 ou 1)	
	jmpc @N r1
	Body
	@N : __
*/
{
	int derniereAdresse = getAdresseTS(getIndexCourantTS());
	ajouterInstr2("load", 1, derniereAdresse);

	popTS();

	ajouterInstr2("jmpc", -1, 1); 
	//on stocke l'idx dans la tinstr de l'instr jmpc dans le tIF 
	$1 = getMemInstruction()-1;
}
 Body
{
	// on remplit l'arg -1 temporaire avec le nouveau memoire_instruction (pc)
	// qui a sans doute été changé dans le Body de la règle
	getInstrAtIdx($1).arg[0]=getMemInstruction();
}
	//le if le plus près du else est le plus prioritaire


//règle : BlocIf : tIF tPARO Condition tPARF Body Else ;
| tIF tPARO Condition tPARF 
/*
on génère : 
	load r1 derniereAdresseTS (contenant le rés de la condition, 0 ou 1)	
	jmpc @i+1 r1
	Body
	@i : jmp @N
	Else
	@N : __
*/
{
	int derniereAdresse = getAdresseTS(getIndexCourantTS());

	ajouterInstr2("load", 1, derniereAdresse);
	
	popTS();

	ajouterInstr2("jmpc", -1, 1); 
	//on stocke l'idx dans la tinstr de l'instr jmpc dans le tIF 
	$1 = getMemInstruction()-1;
}
Body 
{
	

	// ajout d'un jump pour sauter à la fin de tous les else
	ajouterInstr1("jmp", -1);

	// on stocke l'adresse de cette instruction
	$<e>2 = getMemInstruction()-1;

	// on remplit l'arg -1 temporaire avec le nouveau memoire_instruction (pc)
	// qui a sans doute été changé dans le Body de la règle
	getInstrAtIdx($1).arg[0]=getMemInstruction();
}
Else 
{
	getInstrAtIdx($<e>2).arg[0]=getMemInstruction();
}
;

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
/*
on génère : 
	load r0 derniereAdresseTS
	load r1 avantDerniereAdresseTS
	supe r0 r0 r1
	store avantDerniereAdresseTS r0 (adresse qui est désormais la dernière)
*/
{
	
	printf("Cond Supe\n"); 

	//les adresses des valeurs de Calcul sont forcément les deux dernières lignes de la tsymbol
	int i = getIndexCourantTS();
	int adresse_i = getAdresseTS(i);
	
	//on rajoute l'instruction dans la table d'instruction
	printf("LOAD r0 %d", adresse_i);
	ajouterInstr2("load", 0, adresse_i);

	popTS();
	
	int j = getIndexCourantTS();
	int adresse_j = getAdresseTS(j);
	
	//on rajoute l'instruction dans la table d'instruction
	printf("LOAD r1 %d", adresse_j);
	ajouterInstr2("load", 1, adresse_j);

	//on ajoute l'instruction SUPE r0 r0 r1
	printf("SUPE r0 r0 r1");	
	ajouterInstr3("supe", 0, 0, 1);

	//on ajoute l'instruction : STORE getIndexCourantTS() r0
	//on utilise adresse j car on veut écrire par dessus
	printf("STORE %d r0", adresse_j);	
	ajouterInstr2("store", adresse_j, 0);
}
| Calcul tINFEGAL Calcul 
/*
on génère : 
	load r0 derniereAdresseTS
	load r1 avantDerniereAdresseTS
	infe r0 r0 r1
	store avantDerniereAdresseTS r0 (adresse qui est désormais la dernière)
*/
{
	
	printf("Cond Supe\n"); 

	//les adresses des valeurs de Calcul sont forcément les deux dernières lignes de la tsymbol
	int i = getIndexCourantTS();
	int adresse_i = getAdresseTS(i);
	
	//on rajoute l'instruction dans la table d'instruction
	printf("LOAD r0 %d", adresse_i);
	ajouterInstr2("load", 0, adresse_i);

	popTS();
	
	int j = getIndexCourantTS();
	int adresse_j = getAdresseTS(j);
	
	//on rajoute l'instruction dans la table d'instruction
	printf("LOAD r1 %d", adresse_j);
	ajouterInstr2("load", 1, adresse_j);

	//on ajoute l'instruction INFE r0 r0 r1
	printf("INFE r0 r0 r1");	
	ajouterInstr3("infe", 0, 0, 1);

	//on ajoute l'instruction : STORE getIndexCourantTS() r0
	//on utilise adresse j car on veut écrire par dessus
	printf("STORE %d r0", adresse_j);	
	ajouterInstr2("store", adresse_j, 0);
}
| Calcul tSUP Calcul 
/*
on génère : 
	load r0 derniereAdresseTS
	load r1 avantDerniereAdresseTS
	sup r0 r0 r1
	store avantDerniereAdresseTS r0 (adresse qui est désormais la dernière)
*/
{
	printf("Cond\n"); 

	//les adresses des valeurs de Calcul sont forcément les deux dernières lignes de la tsymbol
	int i = getIndexCourantTS();
	int adresse_i = getAdresseTS(i);
	
	//on rajoute l'instruction dans la table d'instruction
	printf("LOAD r0 %d", adresse_i);
	ajouterInstr2("load", 0, adresse_i);

	popTS();
	
	int j = getIndexCourantTS();
	int adresse_j = getAdresseTS(j);
	
	//on rajoute l'instruction dans la table d'instruction
	printf("LOAD r1 %d", adresse_j);
	ajouterInstr2("load", 1, adresse_j);

	//on ajoute l'instruction INFE r0 r0 r1
	printf("INFE r0 r0 r1");	
	ajouterInstr3("infe", 0, 0, 1);

	//on ajoute l'instruction : STORE getIndexCourantTS() r0
	//on utilise adresse j car on veut écrire par dessus
	printf("STORE %d r0", adresse_j);	
	ajouterInstr2("store", adresse_j, 0);
}
| Calcul tINF Calcul
/*
on génère : 
	load r0 derniereAdresseTS
	load r1 avantDerniereAdresseTS
	inf r0 r0 r1
	store avantDerniereAdresseTS r0 (adresse qui est désormais la dernière)
*/
{
	
	printf("Cond INF\n"); 

	//les adresses des valeurs de Calcul sont forcément les deux dernières lignes de la tsymbol
	int i = getIndexCourantTS();
	int adresse_i = getAdresseTS(i);
	
	//on rajoute l'instruction dans la table d'instruction
	printf("LOAD r0 %d", adresse_i);
	ajouterInstr2("load", 0, adresse_i);

	popTS();
	
	int j = getIndexCourantTS();
	int adresse_j = getAdresseTS(j);
	
	//on rajoute l'instruction dans la table d'instruction
	printf("LOAD r1 %d", adresse_j);
	ajouterInstr2("load", 1, adresse_j);

	//on ajoute l'instruction INF r0 r0 r1
	printf("INF r0 r0 r1");	
	ajouterInstr3("inf", 0, 0, 1);

	//on ajoute l'instruction : STORE getIndexCourantTS() r0
	//on utilise adresse j car on veut écrire par dessus
	printf("STORE %d r0", adresse_j);	
	ajouterInstr2("store", adresse_j, 0);
}
 | Calcul tDIFF Calcul 
/*
on génère : 
	load r0 derniereAdresseTS
	load r1 avantDerniereAdresseTS
	equ r0 r0 r1
	afc r1 0
	equ r0 r0 r1
	store avantDerniereAdresseTS r0 (adresse qui est désormais la dernière)
*/
{
	
	printf("Cond DIFF\n"); 

	//les adresses des valeurs de Calcul sont forcément les deux dernières lignes de la tsymbol
	int i = getIndexCourantTS();
	int adresse_i = getAdresseTS(i);
	
	//on rajoute l'instruction dans la table d'instruction
	printf("LOAD r0 %d", adresse_i);
	ajouterInstr2("load", 0, adresse_i);

	popTS();
	
	int j = getIndexCourantTS();
	int adresse_j = getAdresseTS(j);
	
	//on rajoute l'instruction dans la table d'instruction
	printf("LOAD r1 %d", adresse_j);
	ajouterInstr2("load", 1, adresse_j);

	/*
	pour vérifier que r0 != r2 on va d'abord faire un equ
	puis comparer le résultat de ce equ avec 0 (avec equ)
	*/
	printf("EQU r0 r0 r1");	
	ajouterInstr3("equ", 0, 0, 1);

	//on met 0 dans r1
	printf("AFC r1 0");
	ajouterInstr2("afc", 1, 0);

	//on compare ensuite avec 0
	printf("EQU r0 r0 r1");	
	ajouterInstr3("equ", 0, 0, 1);

	//(le move fr)


	//on ajoute l'instruction : STORE getIndexCourantTS() r0
	//on utilise adresse j car on veut écrire par dessus
	printf("STORE %d r0", adresse_j);	
	ajouterInstr2("store", adresse_j, 0);
}
| Calcul tEGAL Calcul
/*
on génère : 
	load r0 derniereAdresseTS
	load r1 avantDerniereAdresseTS
	equ r0 r0 r1
	store avantDerniereAdresseTS r0 (adresse qui est désormais la dernière)
*/ 
{	
	printf("Cond EGAL\n"); 

	//les adresses des valeurs de Calcul sont forcément les deux dernières lignes de la tsymbol
	int i = getIndexCourantTS();
	int adresse_i = getAdresseTS(i);
	
	//on rajoute l'instruction dans la table d'instruction
	printf("LOAD r0 %d", adresse_i);
	ajouterInstr2("load", 0, adresse_i);

	popTS();
	
	int j = getIndexCourantTS();
	int adresse_j = getAdresseTS(j);
	
	//on rajoute l'instruction dans la table d'instruction
	printf("LOAD r1 %d", adresse_j);
	ajouterInstr2("load", 1, adresse_j);

	//on ajoute l'instruction EQU r0 r0 r1
	printf("EQU r0 r0 r1");	
	ajouterInstr3("equ", 0, 0, 1);

	//on ajoute l'instruction : STORE getIndexCourantTS() r0
	//on utilise adresse j car on veut écrire par dessus
	printf("STORE %d r0", adresse_j);	
	ajouterInstr2("store", adresse_j, 0);
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
