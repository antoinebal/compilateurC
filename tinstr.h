#include <stdio.h>
#include <string.h>

typedef struct instruction instruction;
struct instruction {
	char* instr; //load, store, etc.
	int arg[3]; //numéro de registre ou adresse
};

void ajouterFlag(char* flag);
void ajouterInstr1(char* instr, int arg);
void ajouterInstr2(char* instr, int arg1, int arg2);
void ajouterInstr3(char* instr, int arg1, int arg2, int arg3);
int getMemInstruction();
instruction getInstrAtIdx(int index);
