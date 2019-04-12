#include <stdio.h>
#include <string.h>

typedef struct instruction instruction;
struct instruction {
	char* instr; //load, store, etc.
	argument arg[3]; //numéro de registre ou adresse
};

typedef struct argument argument;
struct argument {
	//nature = 1 si valeur est une adresse, =0 si c'est un registre, =2 si c'est une constante 
	int nature;
	int valeur;
}

instruction ti[1024];

int idx = 0;

void ajouterFlag(char* flag) {
	ti[idx].instr=flag;
	idx++;
}

void ajouterInstr(char* instr, argument arg) {
	ti[idx].instr=instr;
	ti[idx].arg[0]=arg;
	idx++;
}

void ajouterInstr(char* instr, argument arg1, argument arg2) {
	ti[idx].instr=instr;
	ti[idx].arg[0]=arg1;
	ti[idx].arg[1]=arg2;
	idx++;
}

void ajouterInstr(char* instr, argument arg1, argument arg2, argument arg3) {
	ti[idx].instr=instr;
	ti[idx].arg[0]=arg1;
	ti[idx].arg[1]=arg2;
	ti[idx].arg[2]=arg3;
	idx++;
}
