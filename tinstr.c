#include <stdio.h>
#include <string.h>

typedef struct instruction instruction;
struct instruction {
	char* instr; //load, store, etc.
	int arg[3]; //numéro de registre ou adresse
};

/*
typedef struct int int;
struct int {
	//nature = 1 si valeur est une adresse, =0 si c'est un registre, =2 si c'est une constante 
	int nature;
	int valeur;
}
*/

instruction ti[1024];


//en fait c'est la mémoire d'instruction t'as vu ;)
int idx = 0;

void ajouterFlag(char* flag) {
	ti[idx].instr=flag;
	idx++;
}

void ajouterInstr(char* instr, int arg) {
	ti[idx].instr=instr;
	ti[idx].arg[0]=arg;
	idx++;
}

void ajouterInstr(char* instr, int arg1, int arg2) {
	ti[idx].instr=instr;
	ti[idx].arg[0]=arg1;
	ti[idx].arg[1]=arg2;
	idx++;
}

void ajouterInstr(char* instr, int arg1, int arg2, int arg3) {
	ti[idx].instr=instr;
	ti[idx].arg[0]=arg1;
	ti[idx].arg[1]=arg2;
	ti[idx].arg[2]=arg3;
	idx++;
}


int getMemInstruction() {
	return idx;
}

int getInstructionAtIdx(int index) {
	return ti[index];
}
