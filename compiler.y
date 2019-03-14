%{
	int yylex(void);
	void yyerror(char*);
%}

%token tMAIN tACCO tACCF tCONST tPARO tPARF tINT tPRINTF tWHILE tIF tPLUS tMULT tMOINS tDIV tAFFECT tSUPEGAL tINFEGAL tSUP tINF tDIFF tEGAL tNOT tVIRGULE tRETURN tNB tNOM tPV tVOID tID

%%

start : FonctionsG ;
FonctionsG : Main | Main Fonctions;
Main : tVOID tMAIN tPARO Arguments tPARF BodyFonction;
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
Action : Affectation | Bloc | AppelFonction; 
Affectation : tID tAFFECT Calcul tPV;
//cette fonction doit retourner un int
Calcul : Grandeur | Grandeur Operateur Calcul | AppelFonction;
Grandeur : tNB | tID;
Operateur : tPLUS|tMULT|tMOINS|tDIV;
Bloc : Cle tPARO Condition tPARF Body;
Cle : tIF|tWHILE;
//body spécial qui ne permet pas les déclarations
Body : tACCO Actions tACCF ;
Condition : Cond | tNOT Cond ;
Cond : Calcul OpCondi Calcul ;
OpCondi : tSUPEGAL|tINFEGAL|tSUP|tINF|tDIFF|tEGAL;
//cette fonction doit être void
AppelFonction : tID tPARO Args tPARF tPV;
//même chose que dans la déclaration des fonctions mais sans les types
Args : Arg tVIRGULE Arg | Arg ; 
Arg : Calcul ;

%%
/*
int main(void) {
#ifdef YYDEBUG
	yydebug = 1;
#endif
	yyparse();
}*/
