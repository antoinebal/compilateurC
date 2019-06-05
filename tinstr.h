#include <stdio.h>
#include <string.h>

//élément constituant la table
typedef struct instruction instruction;
struct instruction {
	char* instr; //load, store, etc.
	int arg[3]; //numéro de registre ou adresse
};


void ajouterFlag(char* flag);

//ajouter une instruction prenant un argument
void ajouterInstr1(char* instr, int arg);

//ajouter une instruction prenant deux arguments
void ajouterInstr2(char* instr, int arg1, int arg2);

//ajouter une instruction prenant trois arguments
void ajouterInstr3(char* instr, int arg1, int arg2, int arg3);

//retourne l'index courant dans la table
int getMemInstruction();

instruction getInstrAtIdx(int index);

void printInstr(instruction instr);

//print toute la table d'instruction
void printT_Instr();

//écrire l'instruction instr dans le fichier file
void ecritInstr(instruction instr, FILE *file);

//écrire les instructions de la table dans assembleur.s
void ecritT_Instr();

//modifier l'argument de numéro numeroArg de l'instruction d'index index par newValue
void modifierInstrAtIdx(int index, int numeroArg, int newValue);
