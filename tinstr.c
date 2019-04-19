#include <stdio.h>
#include <string.h>
#include "tinstr.h"


instruction ti[1024];


//en fait c'est la mémoire d'instruction t'as vu ;)
int idx = 0;

void ajouterFlag(char* flag) {
	ti[idx].instr=flag;
	idx++;
}

void ajouterInstr1(char* instr, int arg) {
	ti[idx].instr=instr;
	ti[idx].arg[0]=arg;
	idx++;
}

void ajouterInstr2(char* instr, int arg1, int arg2) {
	ti[idx].instr=instr;
	ti[idx].arg[0]=arg1;
	ti[idx].arg[1]=arg2;
	idx++;
}

void ajouterInstr3(char* instr, int arg1, int arg2, int arg3) {
	ti[idx].instr=instr;
	ti[idx].arg[0]=arg1;
	ti[idx].arg[1]=arg2;
	ti[idx].arg[2]=arg3;
	idx++;
}


//retourne l'idx courant dans la table
int getMemInstruction() {
	return idx;
}

instruction getInstrAtIdx(int index) {
	return ti[index];
}
